FiniteAutomatonDeterministic = {}
FiniteAutomatonDeterministic.__index = FiniteAutomatonDeterministic

function FiniteAutomatonDeterministic:Generate(states, alphabet, transitionFunction, initialState, endStates)
    local this = {
        states = states,
        alphabet = alphabet,
        transitionFunction = transitionFunction,
        initialState = initialState,
        endStates = endStates
    }
    setmetatable(this, FiniteAutomatonDeterministic)
    return this
end

function FiniteAutomatonDeterministic:getstate(state)
    
end
