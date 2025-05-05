# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  { name: 'Aさん', email: 'a@example.com', password: '111111' },
  { name: 'Bさん', email: 'b@example.com', password: '111111' },
  { name: 'Cさん', email: 'c@example.com', password: '111111' },
  { name: 'Dさん', email: 'd@example.com', password: '111111' }
])

Group.create!([
  { name: 'TEST'}
])

Membership.create!([
  { user_id: 1, group_id: 1},
  { user_id: 2, group_id: 1},
  { user_id: 3, group_id: 1},
  { user_id: 4, group_id: 1}
])