require("src/automaton")

automatonmodel = {}
automatonmodel.states = { 'q0', 'q1', 'q2', 'qf' }
automatonmodel.states.initialstate = 'q0'
automatonmodel.states.finalstate = 'qf'

automatonmodel.alphabet = {'a', 'b'}

automatonmodel.fnc = { 
  -- From | Apply | To
  {'q0', 'a', 'q1'}, 
  {'q0', 'b', 'q2'},
  {'q1', 'a', 'qf'},
  {'q1', 'b', 'q2'},
  {'q2', 'a', 'q1'},
  {'q2', 'b', 'qf'}
}

-- Generates the automaton
elevatorfad = FiniteAutomatonDeterministic.create(
  automatonmodel.states, automatonmodel.alphabet, automatonmodel.fnc,
  automatonmodel.states.initialstate, automatonmodel.states.finalstate
)
