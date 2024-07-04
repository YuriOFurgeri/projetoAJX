O projeto foi feito utilizando Flutter para o frontend e AdonisJs para o backend.

--------BACKEND------------
Para iniciar o projeto, comece pelo arquivo projetoAJX/back
(na raiz do projeto utilize o comando: cd back)
Aqui está o backend em AdonisJS. Para inicializalo e puxar as dependencias, utilize o comando:
npm install
É necessário incluir o .env com os detalhes do seu banco de dados, como senha, o nome do banco de dados e o usuário a acessar.(Obs: necessário criar o banco também)
Este projeto, ele foi feito para ser utilizado o banco de dados Mysql, portanto adicionar outro banco irá precisar de alterações no arquivo back/config/database.js
Ao acessar inicialmente o backend também é necessário atualizar os dados do back/config/database.js
Altere os dados de acordo com os dados do seu banco de dados.
Ao ter atualizado, então prosiga com os códigos para inicializar as migrações do Adonis:
adonis migration:run
em seguida, utilize o comando para popular as tabelas do seu banco
adonis seed
(ou: node ace migration:run --seed)
Ao fazer esses passos, o backend está pronto para o uso. Então suba o servidor para poder utiliza-lo. (É necessário o banco de dados aberto)
E então use o comando:
adonis serve
(ou o comando: node ace serve --watch)
E deixe o servidor do adonis rodando de fundo para conectar a aplicação depois.

(obs: Caso ocorra erros de dependências, é recomendável utilizar a versão 19.9.0 do Node)

------FRONTEND-----------
Na pasta raiz do projeto, execute o comando: cd front
Acessando o frontend, importe as dependencias do projeto utilizando o comando:
flutter pub get
Depois de instalar as dependencias, falta apenas rodar a aplicação.
Como o flutter é multiplataforma, você pode rodar em qualquer dispositivo se tiver a extensão do VSCode ou do AndroidStudio,
Porém para um primeiro teste é interessante executar ele no navegador (web), e para isso o comando:
flutter run
(Aparecerá uma caixa de opções, digite 2, referente ao Web, e então aperte enter).
Com isso, a aplicação deve funcionar, a primeira execução normalmente tende a ser mais demorada, então aguarde um pouco e caso não carregue, tente atualizar a página).
Assim, utilizando a aplicação.
(Caso ainda assim não abra, verifique se o backend ainda está em andamento)


-----Sobre a utilização da aplicação------------
A tela inicial possui uma barra de pesquisa para buscar os itens,
As Categorias que representam listas de itens,
E os produtos, que são os itens, possuindo dados como preço, descrição e imagens ilustrativas (alguns com opções também).
Ao clicar em um produto, será redirecionado para uma página com os detalhes dele, podendo selecionar se vai adiciona-lo no carrinho. (Ou se possuir, se irá colocar um dos adicionais nele, ou opções).
(obs: Os itens ficam salvos por vez que entra na página, portanto atualizar reiniciara o carrinho).
No carrinho, ficarão salvos os itens que selecionar, podendo também remover se quiser, e o preço da soma total dos produtos.
(Cada item é unico na lista pois eles podem ter detalhes diferentes, por exemplo: Uma coca-cola lata, Uma coca-cola lata + Copo com gelo)

Ao apertar o botão de "Enviar Pedido", ele é enviado para a API, com todos os detalhes dos itens, sobre o preço, detalhes individuais e de preferencias.

(Sobre o tratamento de pagamentos e afins, ele está definido como valor padrão de "cartão de crédito", a parte relacionada com financeiro ainda será alterada para mais opções relacionadas ao estabelecimento futuramente).

