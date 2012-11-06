# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
##
##roles = Role.create([{name: 'super_admin'}, {name: 'staff'}, {name:'customer'}])



users = User.create([{email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123', admin: true, payment: '1' }, {email: 'yunjakim3@gmail.com', password: 'admin123', password_confirmation: 'admin123', admin: false, payment: '1' }])

languages = Language.create([ {name: 'English', fullname: 'english', shortname: 'en' },
                              {name: 'Hindi', fullname: 'hindi india', shortname: 'hi' }, 
                              {name: 'Korean', fullname: 'korean korea kr', shortname: 'ko' },
                              {name: 'Japanese', fullname: 'japanese', shortname: 'jp' }, 
                              {name: 'Chinese', fullname: 'China taiwan', shortname: 'zh' },
                              {name: 'Portuguese', fullname: 'portuguese', shortname: 'pt' },
                              {name: 'French', fullname: 'french', shortname: 'fr' },
                              {name: 'Spanish', fullname: 'spanish', shortname: 'es' },
                              {name: 'German', fullname: 'german', shortname: 'de' },
                              {name: 'Greek', fullname: 'greek', shortname: 'gr' },
                              {name: 'Arabic', fullname: 'arabic', shortname: 'ar' },
                              {name: 'Indonesian', fullname: 'indonesian', shortname: 'id' },
                              {name: 'Russian', fullname: 'russian', shortname: 'ru' },
                              {name: 'Malay', fullname: 'malaysia', shortname: 'ms' }
                          ])

searches = Search.create([ { language: 'en' },
                              { language: 'hi' }, 
                              { language: 'ko' },
                              { language: 'jp' }, 
                              { language: 'zh' },
                              { language: 'pt' },
                              { language: 'fr' },
                              { language: 'es' },
                              { language: 'de' },
                              { language: 'gr' }, 
                              { language: 'ar' },
                              { language: 'id' },
                              { language: 'ru' },
                              { language: 'ms' }
                          ])
### rake db:seed

