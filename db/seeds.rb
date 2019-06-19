# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# Post.delete_all
# (1..100).each do |n|
#   Post.create(title: "这是一篇测试文章，标题是#{n}", content: n)
# end

Word.delete_all
word_seeds = JSON.parse "[{\"id\":4,\"text\":\"apprehended\",\"result\":\"被捕\",\"status\":0,\"dict\":[\"动词：拘押，拿，意识，办案，聆，竦，虞，恇恇，拏，挐\"],\"created_at\":\"2019-05-08T16:10:56.795+08:00\",\"updated_at\":\"2019-05-08T16:10:56.795+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=apprehended\"},{\"id\":5,\"text\":\"massacre\",\"result\":\"屠杀\",\"status\":0,\"dict\":[\"动词：屠杀，杀戮，屠，殪\",\"名词：惨案，惨杀，大屠杀\"],\"created_at\":\"2019-05-08T16:11:33.532+08:00\",\"updated_at\":\"2019-05-08T16:11:33.532+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=massacre\"},{\"id\":6,\"text\":\"Columbine\",\"result\":\"鸽的\",\"status\":0,\"dict\":[\"形容词：鸽的，鸽色的\"],\"created_at\":\"2019-05-08T16:11:38.021+08:00\",\"updated_at\":\"2019-05-08T16:11:38.021+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=Columbine\"},{\"id\":7,\"text\":\"expert\",\"result\":\"专家\",\"status\":0,\"dict\":[\"名词：专家，行家，专，能手，内行，在行，师，通，才，分析人士，专业人才\",\"形容词：专，拿手，娴，优\"],\"created_at\":\"2019-05-08T16:11:44.987+08:00\",\"updated_at\":\"2019-05-08T16:11:44.987+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=expert\"},{\"id\":8,\"text\":\"Hawks\",\"result\":\"老鹰\",\"status\":0,\"dict\":null,\"created_at\":\"2019-05-08T16:14:12.651+08:00\",\"updated_at\":\"2019-05-08T16:14:12.651+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=Hawks\"},{\"id\":9,\"text\":\"Squeezes\",\"result\":\"挤压\",\"status\":0,\"dict\":[\"动词：挤，压榨，压缩，拥挤，压扁，插身，塞，压碎，拥，掐尖儿，搜索枯肠\"],\"created_at\":\"2019-05-08T16:14:23.741+08:00\",\"updated_at\":\"2019-05-08T16:14:23.741+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=Squeezes\"},{\"id\":10,\"text\":\"Donald\",\"result\":\"唐纳德\",\"status\":0,\"dict\":null,\"created_at\":\"2019-05-08T16:22:47.033+08:00\",\"updated_at\":\"2019-05-08T16:22:47.033+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=Donald\"},{\"id\":11,\"text\":\"asynchronous\",\"result\":\"异步\",\"status\":0,\"dict\":[\"形容词：异步\"],\"created_at\":\"2019-05-08T18:20:34.844+08:00\",\"updated_at\":\"2019-05-08T18:20:34.844+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=asynchronous\"},{\"id\":12,\"text\":\"mutable\",\"result\":\"易变的\",\"status\":0,\"dict\":[\"形容词：性情不定的，易变的\",\"名词：性情不定\"],\"created_at\":\"2019-05-08T18:27:07.044+08:00\",\"updated_at\":\"2019-05-08T18:27:07.044+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=mutable\"},{\"id\":13,\"text\":\"Schiff subpoenas Barr\",\"result\":\"希夫传票巴尔\",\"status\":0,\"dict\":null,\"created_at\":\"2019-05-09T12:27:17.504+08:00\",\"updated_at\":\"2019-05-09T12:27:17.504+08:00\",\"link\":\"https://translate.google.cn/#view=home\\u0026op=translate\\u0026sl=en\\u0026tl=zh-CN\\u0026text=Schiff%20subpoenas%20Barr\"}]"

word_seeds.each do |seed|
  Word.create(seed)
end