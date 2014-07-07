Admin.destroy_all
Admin.create!([
  {email: "test@test.com", password: '123123aA'}
])
Category.destroy_all
Category.create!([
  {name: "Фотоаппараты", description: nil, parent_id: nil, image: nil, enabled: nil, sort_order: nil},
  {name: "Зеркальные", description: "", parent_id: 1, image: nil, enabled: true, sort_order: nil}
])

Page.destroy_all
Page.create!([
  {name: "Оплата и доставка", text: " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eleifend ultrices justo vel porta. Praesent tristique sem a euismod mattis. Nullam malesuada dapibus dui, eget mattis sapien iaculis sit amet. Phasellus purus massa, tincidunt at erat ullamcorper, tincidunt luctus elit. Ut eleifend tortor non felis porttitor, nec sagittis ligula placerat. Suspendisse in augue vestibulum, semper nisi et, consectetur libero. Etiam aliquet libero dui, in pharetra lectus sollicitudin nec.\r\n\r\nCras iaculis tellus tincidunt lorem laoreet sagittis. Aliquam id ultrices arcu, quis dapibus est. Pellentesque tristique vel diam luctus sodales. Proin at enim consectetur, tincidunt orci vel, condimentum erat. Mauris mattis vehicula lorem, nec sodales magna pharetra quis. In lobortis non dolor quis egestas. Pellentesque et felis commodo, volutpat odio ut, rutrum lorem. Curabitur dui odio, adipiscing imperdiet condimentum condimentum, fringilla eu arcu. Duis ac augue felis. Donec mollis dapibus quam, in ultricies nunc tincidunt viverra.\r\n\r\nMorbi nec accumsan felis, vel posuere turpis. Donec vitae diam vitae quam tempor fermentum. Aenean eleifend massa non nunc gravida, sed cursus tortor imperdiet. Curabitur eu est id urna pharetra hendrerit. Cras blandit in erat eget commodo. Donec dignissim varius elit. Phasellus mollis semper nulla in vehicula. Nulla dui ipsum, iaculis nec elit sit amet, imperdiet tincidunt libero. Maecenas ultrices orci tellus, at facilisis justo condimentum quis. Sed id purus libero. Aenean varius sodales sem quis pellentesque. Nulla vulputate laoreet dolor ut placerat. Ut aliquam egestas tincidunt. Etiam fringilla quis mi eu varius. Vestibulum pellentesque justo felis, a varius massa euismod at.\r\n\r\nUt nec nunc enim. Praesent sit amet auctor nibh. Phasellus convallis est pellentesque, ultricies tellus in, ultricies eros. Sed faucibus pellentesque ante id consectetur. Phasellus nec malesuada elit. Etiam in ligula consequat purus rutrum egestas. Fusce varius ornare eros mattis auctor. Duis ut libero nulla.\r\n\r\nNunc quis mi leo. Donec sit amet purus commodo, adipiscing augue ac, ornare lorem. Maecenas euismod aliquet nibh, nec feugiat eros tincidunt non. Curabitur sit amet pharetra diam. Sed vitae erat porttitor, egestas nulla a, sagittis diam. Nunc vehicula consequat justo et rhoncus. Sed ligula turpis, scelerisque in nibh vel, porttitor eleifend turpis", image: nil, enabled: true, sort_order: nil, position: "menu_and_footer"}
])

Promotion.destroy_all
Promotion.create!([
  {name: "test promotion", description: "", sort_order: nil, enabled: true, has_banner: false, banner: nil, send_mail: false, start_at: "2014-08-07", end_at: "2014-02-07", discount: nil}
])

Settings.destroy_all
Settings.create!([
  {var: "site_title", value: "--- tst shop\n...\n", thing_id: nil, thing_type: nil},
  {var: "site_url", value: "--- http://localhost/\n...\n", thing_id: nil, thing_type: nil},
  {var: "owner_phone", value: "--- +7 (920) 123-45-67\n...\n", thing_id: nil, thing_type: nil},
  {var: "owner_email", value: "--- order@tst.com\n...\n", thing_id: nil, thing_type: nil}
])

Rake::Task['ulmart:update'].invoke
