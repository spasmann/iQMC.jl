"""
Xbase(x0, b, atv, V, eta, pdata; orth="cgs2", lmaxit=-1)

Base GMRES solver. This is GMRES(m) with no restarts and no preconditioning.
The idea for the future is that it'll be called by X_gmres (linear
solver) which is the backend of klgmres.

xgmres_base overwrites x0 with the solution. This is one of many reasons
that you should not invoke it directly.
"""
function Xbase(x0, b, atv, V, eta, pdata; orth = "cgs2", lmaxit = -1)

    (n, m) = size(V)
    #
    # Allocate for Givens
    #
    #    kmax = m - 1
    kmax = m
println("lmaxit = $lmaxit, kmax = $kmax, m = $m")
    lmaxit == -1 || (kmax = lmaxit)
println("lmaxit = $lmaxit, kmax = $kmax")
    kmax > m - 1 && error("lmaxit error in xgmres_base")
    r = zeros(n,)
    r .= b
    T = eltype(V)
    h = zeros(T, kmax + 1, kmax + 1)
    c = zeros(kmax + 1)
    s = zeros(kmax + 1)
    #
    # Don't do the mat-vec if the intial iterate is zero
    #
    y = zeros(n,)
    (norm(x0) == 0.0) || (r .-= atv(x0, pdata))
    #    (norm(x0) == 0.0) || (y .= atv(x0, pdata); r .-=y;)
    #
    #
    rho0 = norm(r)
    rho = rho0
    #
    # Initial residual = 0? This can't be good.
    #
    rho == 0.0 && error("Initial resdiual in X_gmres is zero. Why?")
    #
    g = zeros(size(c))
    g[1] = rho
    errtol = eta * rho
    reshist = []
    #
    # Initialize
    #
    idid = true
    push!(reshist, rho)
    k = 0
    #
    # Showtime!
    #
    @views V[:, 1] .= r / rho
    beta = rho
    while (rho > errtol) && (k < kmax)
        k += 1
        @views V[:, k+1] .= atv(V[:, k], pdata)
        @views vv = vec(V[:, k+1])
        @views hv = vec(h[1:k+1, k])
        @views Vkm = V[:, 1:k]
        #
        # Don't mourn. Orthogonalize!
        #
        Orthogonalize!(Vkm, hv, vv, orth)
        #
        # Build information for new Givens rotations.
        #   
        if k > 1
            hv = @view h[1:k, k]
            giveapp2!(c[1:k-1], s[1:k-1], hv, k - 1)
        end
        nu = norm(h[k:k+1, k])
        if nu != 0
            c[k] = conj(h[k, k] / nu)
            s[k] = -h[k+1, k] / nu
            h[k, k] = c[k] * h[k, k] - s[k] * h[k+1, k]
            h[k+1, k] = 0.0
            gv = @view g[k:k+1]
            giveapp2!(c[k], s[k], gv, 1)
        end
        #
        # Update the residual norm.
        #
        rho = abs(g[k+1])
y = h[1:k, 1:k] \ g[1:k]
qmf = view(V, 1:n, 1:k)
z=copy(x0)
mul!(z, qmf, y, 1.0, 1.0)
restmp=norm(b - atv(z,pdata))
println("Real res = $restmp. Estimated res = $rho")
        (nu > 0.0) || (println("near breakdown"); rho=0.0;)
        push!(reshist, rho)
    end
    #
    # At this point either k = kmax or rho < errtol.
    # It's time to compute x and check out.
    #
    y = h[1:k, 1:k] \ g[1:k]
    qmf = view(V, 1:n, 1:k)
    #    mul!(r, qmf, y)
    #    r .= qmf*y    
    #    x .+= r
    #    sol = x0
    #    mul!(sol, qmf, y, 1.0, 1.0)
    mul!(x0, qmf, y, 1.0, 1.0)
    (rho <= errtol) || (idid = false)
    k > 0 || println("XBASE iteration terminates on entry.")
    return (rho0 = rho0, reshist = Float64.(reshist), lits = k, idid = idid)
end

function giveapp2!(c, s, vin, k)
    for i = 1:k
        w1 = c[i] * vin[i] - s[i] * vin[i+1]
        w2 = s[i] * vin[i] + c[i] * vin[i+1]
        vin[i:i+1] .= [w1, w2]
    end
    return vin
end
