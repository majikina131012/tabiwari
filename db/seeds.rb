# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 既存データを削除
User.destroy_all
Group.destroy_all
Membership.destroy_all
Expense.destroy_all
Share.destroy_all

# ユーザー作成
user_a = User.create!(name: "Aさん", email: "a@example.com", password: "password")
user_b = User.create!(name: "Bさん", email: "b@example.com", password: "password")
user_c = User.create!(name: "Cさん", email: "c@example.com", password: "password")

# グループ作成
group = Group.create!(name: "旅行メンバー")

# グループにユーザーを追加
Membership.create!(user: user_a, group: group)
Membership.create!(user: user_b, group: group)
Membership.create!(user: user_c, group: group)