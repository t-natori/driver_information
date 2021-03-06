# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Genre.create!(
  [
    {
      name: "トイレ"
    },
    {
      name: "駐禁"
    },
    {
      name: "ネズミ捕り"
    }
    ]
  )

Admin.create!(
  email: "test@admin",
  password: "testadmin"
  )

Tag.create([
  { name: "路上駐車" },
  { name: "(近くに)有料駐車場" },
  { name: "無料駐車場" },
  { name: "大型可" },
])