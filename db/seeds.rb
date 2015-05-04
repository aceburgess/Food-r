sherman = User.create(
  name: 'Sherman Ng',
  email: 'sherman.ng10@gmail.com',
  password: '1234'
)

ace = User.create(
  name: 'Ace Burgess',
  email: 'burgess.ace@gmail.com',
  password: '1234'
)

luis = User.create(
  name: 'Luis Echenique',
  email: 'echenique11@gmail.com',
  password: '1234'
)

brendan = User.create(
  name: 'Brendan Miranda',
  email: 'me@brendanmiranda.com',
  password: '1234'
)

phase_2 = Group.create(
  name: 'Phase 2 Crew',
  admin_id: 1,
  organizer_id: 1
)

underground = Group.create(
  name: 'Underground Dance Kings',
  admin_id: 2,
  organizer_id: 2
)

underground.members << [luis, brendan, sherman]
phase_2 << [ace, luis, brendan]




