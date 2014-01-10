node(:success) { true }
child(@user) { extends 'users/user' }
child(@repetitions, object_root: false) { extends 'repetitions/repetition' }
