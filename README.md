<h1>Trabalhando com Esquema de Cenário ou Scenario Outline</h1>

Esquema do Cenário ou Scenario Outline
-------------------------
Bom pessoal, nesse post vou mostrar um exemplo de Esquema do Cenário ou Scenario Outline e como ele é vantajoso para cenários repetitivos.

Mas antes pra quem tem alguma dúvida de como configurar o ruby em seu Windowns, vou deixar um breve material abaixo.

Configurando sua máquina
-------------------------
Necessário instalar:
-----------------------

*	Ruby for Windows: linguagem de programação utilizada nos testes.(Estou utilizando a versão ruby 2.3.3p222)
*	Cmder for Windows: Sistema que trás as funcionalidades bash (Terminal) para o Windows.
*	DevKit: Kit de ferramentas que o sistema operacional precisa para que o desenvolvimento funcione.
*	Chromedriver: Driver do navegador que será utilizado na automação. Disponível no site do <https://sites.google.com/a/chromium.org/chromedriver/downloads>.
*	Atom: Editor de texto com funções úteis para escrever o código da automação de testes.


Configurando o ambiente de automação de testes Web
------------------------------------------------------------

Para que sua automação possa ser realizada é necessário instalar alguns recursos, conforme será descrito abaixo:

Windows
--------

<h3>1. Instalando o Console do Cmder</h3>

*	Baixe em: <https://github.com/cmderdev/cmder/releases/download/v1.3.2/cmder.zip> .
*	Descompactar na pasta C:\Cmder.
*	Selecione o cmder.exe e arrastar até sua barra de ferramentas do Windows para criar um atalho.
*	Executar o cmder.exe.

<h3>2. Instalando o Ruby para Windows de acordo com a versão do seu sistema operacional e arquitetura x86 (32bits) ou x64 (64bits)</h3>

*	Baixe em: <http://rubyinstaller.org/downloads/>.
*	Executar o arquivo baixado e seguir as instruções clicando em ‘next’.
* Selecionar os 3 checkbox exibidos e continuar a dar ‘next’ até o ‘finish’.
*	No Console do Cmder, digite o comando ruby –v , se a instalação estiver correta aparecerá a versão instalada.

<h3>3. Instalando Devkit</h3>

*	Baixe em (x86): <https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe>.
* Baixe em (x64): <http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe>.
*	Acesse o diretório C:\Ruby23-x64.
*	Crie uma pasta chamada devkit e coloque o arquivo baixado dentro dessa pasta.
*	Clique duas vezes no arquivo para que ele descompate os arquivos na pasta que foi criada.
*	No Console do Cmder, digite os comandos:

```bash
cd/
cd C:\Ruby23-x64\devkit
ruby dk.rb init
ruby dk.rb install
```

<h3>4. Alterando os sources do rubygems</h3>

O Rubygems precisa de uma atualização de certificado de sergurança para permitir utilizar com https,
e para não precisar atualizar isso, passamos a utilizar então o repositório de gems em http, fazendo o
seguinte:
*	No Console do Cmder, digite o comando:
```bash
gem sources -a http://rubygems.org/
gem sources -r https://rubygems.org/
```

<h3>5. Instalando o bundler</h3>

No Console do Cmder, digite o comando:
```bash
gem install bundler
```

<h3>6. Instalando o chromedriver</h3>

Baixe o chromedriver em: <https://sites.google.com/a/chromium.org/chromedriver/downloads> .
*	Descompacte o arquivo dentro da pasta C:\Ruby23-x64\bin.

E pronto, ambiente configurado.

Clonando o repositório do git para execução dos teste
------------------------------------------------------

<h3>Selecionando o destino para o clone do projeto</h3>

*	Navegue no Cmder até a pasta em que você achar mais apropriada para ser feito o clone do projeto, como exemplo vou utilizar a pasta projetos dentro de C:.
```bash
cd/
cd projetos
```

<h3>Clonando o repositório </h3>

*	No Console do Cmder, digite o comando:

````bash
git clone https://github.com/felipeqa/scenario-outline.git
````
Como é possível ver, a estrutura do comando é "git clone [endereço do repositório] .

Feito isso, temos um clone do projeto para que possamos trabalhar e executar os testes automatizados.


Automação de Testes
--------------------

Para a automação de testes algumas gems do Ruby são essenciais, sendo elas:
*	Cucumber
*	Capybara
*	Selenium-webdriver

Para manter o controle das Gems usadas no projeto, adicione no arquivo Gemfile e serão instaladas de uma só vez.
Com o arquivo Gemfile configurado, utiliza-se a gem bundler para instalação das dependências listadas:
Instalando a Gem bundler
```bash
cd C:\projetos\scenario-outline
gem install bundler
```

Baixando as dependências do projeto
```bash
bundler install
```

**Observação o bundler install precisa encontrar um Gemfile para poder baixar as dependências.**


Agora vamos falar de Esquema do Cenários ou Scenario Outline
--------------------
<h4>Primeiro vou contar um pouco sobre meu dia-a-dia no trabalho</h4>

Ultimamente tenho utilizado frequentemente no meu trabalho essa abordagem, pois preciso variar muito meus cenários.
Pra quem não conhece eu trabalho na [Almundo Brasil.](https://almundo.com.br/)
Como minha empresa atua em outros países como Argentina, Colômbia e México, tenho que variar meus cenários contemplando esse países e o Brasil. Em média eu costumo colocar 15 variações de cenários, o meu maior ganho é que:

Se eu precisar fazer um teste de uma nova variação eu simplesmente adiciono esse novos parâmetros de entrada e o cenário deve chegar ao mesmo resultado. É uma abordagem muito produtiva está ajudando muito atualmente! Mas agora vamos voltar ao assunto principal: **Esquema de Cenário ou Scenario Outline**

Então, copiar e colar cenários para usar valores diferentes rapidamente é bem chato e bem feio também.

```
Cenário: Validar usuários admin0

Dado um usuário na home de um sistema
Quando utilizo seu usuário "admin0" e sua senha "admin0"
Então verifico que não é permitido o acesso desse usuário a esse sistema

Cenário: Validar usuários admin1

Dado um usuário na home de um sistema
Quando utilizo seu usuário "admin1" e sua senha "admin1"
Então verifico que não é permitido o acesso desse usuário a esse sistema
```

O Esquema do Cenário nos permite expressar claramente esses exemplos por meio do uso de um modelo com marcadores <>, esses marcadores são utilizados para criar nossa tabela de valores posteriormente (exemplos):

````
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
````

Sem entrar no mérito técnico, o que acontece aqui é o seguinte:

O Esquema do Cenário nunca é executado diretamente, ele é como um modelo. Se vc por exemplo apagar os exemplos(redundante isso neh? mas ok!!!) e a tabela e tentar rodar esse cenário vc vai constatar isso.(Faça isso aí no seu projeto e veja o resultado.)

````
Esquema do Cenário: Validar diversos usuários - Usuários que não possuem acesso a essa aplicação

  Dado que um usuário esteja na home de um sistema
  Quando utilizo seu usuário <user> e sua senha <password>
  Então verifico que não é permitido o acesso desse usuário a esse sistema
````

Toda a magia esta por trás dos Exemplos.

````
Exemplos:
|user      |password|
|'admin0'  |'admin0'|
|'admin1'  |'admin1'|
|'admin2'  |'admin2'|
|'admin3'  |'admin3'|
|'admin4'  |'admin4'|
|'admin5'  |'admin5'|
|'tomsmith'|'SuperSecretPassword!'|
````
Ou seja, para cada linha(exceto a primeira, que vc passa os mesmos valores que passou dentro dos marcadores **<user>** e **<password>** ) o cenário é executado com o valor correspondente.   

E como fica esse step gerado com os marcadores? Boa pergunta neh?
````
Using the default profile...
# language: pt
#encoding: utf-8
Funcionalidade: Aqui vc descreve a sua Funcionalidade
  Como usuario de qualquer coisa
  Quero fazer alguma coisa
  Para que eu tenha o meu resultado esperado

  #Agora iremos criar um scenario outline - esquema do cenário
  Esquema do Cenário: Validar diversos usuários - Usuários que não possuem acesso a essa aplicação
    Dado que um usuário esteja na home de um sistema
    Quando utilizo seu usuário <user> e sua senha <password>
    Então verifico que não é permitido o acesso desse usuário a esse sistema

    Exemplos:
      | user       | password               |
      | 'admin0'   | 'admin0'               |
      | 'admin1'   | 'admin1'               |
      | 'admin2'   | 'admin2'               |
      | 'admin3'   | 'admin3'               |
      | 'admin4'   | 'admin4'               |
      | 'admin5'   | 'admin5'               |
      | 'tomsmith' | 'SuperSecretPassword!' |

7 scenarios (7 undefined)
21 steps (21 undefined)
0m0.060s

You can implement step definitions for undefined steps with these snippets:

Dado("que um usuário esteja na home de um sistema") do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando("utilizo seu usuário {string} e sua senha {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Então("verifico que não é permitido o acesso desse usuário a esse sistema") do
  pending # Write code here that turns the phrase above into concrete actions
end
````
**LEGAL!!!** Mas 7 cenários? 21 steps?

Isso mesmo, é como eu disse! Para cada linha de exemplos é um cenário diferente.

Agora vamos focar apenas no step onde é passado os marcadores **<user>** e **<password>**.
````
Quando("utilizo seu usuário {string} e sua senha {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end
````
Como podemos ver o Cucumber criar o mesmo modelo que já estamos acostumados a trabalhar quando passamos alguns parâmetros ou tabelas na escrita do cenário, então nada muda na hora de implementar os steps.

Agora que aprendemos um pouco sobre Esquema do Cenário ou Scenario Outline eu me despeço, espero que gostem é que seja útil no seu dia-a-dia.

Mais Informações [Scenario Outline](https://github.com/felipeqa/scenario-outline)

Até o próximo post.

Contato
-------
Estou aberto a sugestões, elogios, críticas ou qualquer outro tipo de comentário.

*	E-mail: felipe_rodriguesx@hotmail.com.br
*	Linkedin: <https://www.linkedin.com/in/luis-felipe-rodrigues-de-oliveira-2b056b5a/>

Licença
-------
Esse código é livre para ser usado dentro dos termos da licença MIT license
