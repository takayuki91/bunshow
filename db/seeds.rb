# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 管理者アカウント
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD_CONFIRMATION']
)

leader = Community.create(name: "指導者(カテゴリなし)")
teacher, coach = leader.children.create(
  [
    { name: "教員(カテゴリなし)" },
    { name: "コーチ(カテゴリなし)" },
  ]
)

["幼稚園教員", "保育士", "小学校教員", "中学校教員", "高等学校教員", "特別支援学校教員", "大学・大学院教員", "専門学校教員", "塾・予備校講師"].each do |name|
  teacher.children.create(name: name)
end

["スポーツコーチ", "ビジネスコーチ", "ライフコーチ", "カウンセリングコーチ"].each do |name|
  coach.children.create(name: name)
end
