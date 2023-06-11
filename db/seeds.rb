# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

管理者アカウント
Admin.create!(
  email: "admin@example.com",
  password: "hogehoge",
  password_confirmation: "hogehoge"
)

leader = Community.create(name: "指導者")
teacher, coach = leader.children.create(
  [
    { name: "教員" },
    { name: "コーチ" },
  ]
)

["幼稚園・保育園", "小学校", "中学校", "高等学校", "大学・大学院", "専門学校", "他のカテゴリ"].each do |name|
  teacher.children.create(name: name)
end

["スポーツ", "ビジネス", "ライフ", "カウンセリング", "他のカテゴリ"].each do |name|
  coach.children.create(name: name)
end
