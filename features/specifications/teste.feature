#encoding: utf-8
#language: pt

Funcionalidade: Aqui vc descreve a sua Funcionalidade
  Como usuario de qualquer coisa
  Quero fazer alguma coisa
  Para que eu tenha o meu resultado esperado

# Agora iremos criar um scenario outline - esquema do cenário
# Como não encontrei um exemplo melhor, esse teste vai garantir que esses usuários
# exceto o último não podem fazer esse login!

Esquema do Cenário: Validar diversos usuários - Usuários que não possuem acesso a essa aplicação

  Dado que um usuário esteja na home de um sistema
  Quando utilizo seu usuário <user> e sua senha <password>
  Então verifico que não é permitido o acesso desse usuário a esse sistema

  Exemplos:
  |user      |password|
  |'admin0'  |'admin0'|
  |'admin1'  |'admin1'|
  |'admin2'  |'admin2'|
  |'admin3'  |'admin3'|
  |'admin4'  |'admin4'|
  |'admin5'  |'admin5'|
  |'tomsmith'|'SuperSecretPassword!'|
