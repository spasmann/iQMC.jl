include("../QMC.jl")

function sobolMatrix(N, dim)
    # generate matrix of sobol numbers
    sobol = QMC.SobolSeq(dim)
    rng = zeros(N, dim)
    for i in 1:N
        temp = QMC.next!(sobol)
        rng[i,:] = temp
    end
    return rng
end

function goldenMatrix(N,dim)
    # generate matrix of golden sequence numbers
    golden = QMC.GoldenSequence(dim)
    rng = zeros(N, dim)
    for i in 1:dim
        rng[:,i] = golden[1:N][i]
    end
    return rng
end

"""
Monte Carlo integration of lambda function "f"
"""
function mcIntegration(LB, RB, random_numbers, N, dim)
    sum = 0.0
    for i in 1:dim
        xvec = random_numbers[:,i]
        sum += f(xvec)
    end
    answer = sum*(RB-LB)/N

    return answer
end

function f(x)
    N = length(x)
    answer = 1.0/x[1]
    for i in 2:N
        answer *= 1.0/x[i]
    end
    return answer
end


function QMC_error()
    LB = 1.0
    RB = exp(1)
    N = 100000
    dim = 20
    sobol_error = zeros(dim)
    random_error = zeros(dim)

    for i in 1:dim
        sobol = sobolMatrix(N, i).*(RB-LB) .+ LB
        random = QMC.rand(N,i).*(RB-LB) .+ LB
        #golden = goldenMatrix(i)

        sobol_answer = mcIntegration(LB,RB,sobol,N,i)
        random_answer = mcIntegration(LB,RB,random,N,i)

        sobol_error[i] = abs(1.0-sobol_answer)
        random_error[i] = abs(1.0-random_answer)
    end
    #println("Integration Error = ", abs(answer-1.0))
    QMC.figure()
    QMC.plot(1:dim, sobol_error, label = "Sobol")
    QMC.plot(1:dim, random_error, label = "Random")
    #QMC.ylim(0.001, 0.01)
    QMC.legend()
end
QMC_error()
