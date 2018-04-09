Dado("que um usuário esteja na home de um sistema") do
  visit 'https://the-internet.herokuapp.com/login'
end

Quando("utilizo seu usuário {string} e sua senha {string}") do |_user, _password|
  find('#username').set _user
  find('#password').set _password
  find('button[type="submit"]').click
end

Então("verifico que não é permitido o acesso desse usuário a esse sistema") do
  assert_text "Your username is invalid!"
end
