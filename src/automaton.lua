require('utils')

FiniteAutomatonDeterministic = {}
FiniteAutomatonDeterministic.__index = FiniteAutomatonDeterministic

function FiniteAutomatonDeterministic:create(states, alphabet, transitionFunction, initialState, endStates)
    local this = {
        states = states,
        alphabet = alphabet,
        transitionFunction = transitionFunction,
        actualState = initialState,
        initialState = initialState,
        endStates = endStates
    }
    setmetatable(this, FiniteAutomatonDeterministic)
    return this
end

function FiniteAutomatonDeterministic:checkstring(stringW)
    local stringIsValid = false;

    for index=1, #stringW do
        self.generatestate(stringW:sub(index, index));
    end
    
    if arrayHasValue(self.actualState, self.endStates) then
        self.actualState = self.initialState;
        stringIsValid = true;
    end
    return stringIsValid;
end

function FiniteAutomatonDeterministic:generatestate(state)
    self.actualState = self.states[state];
end
