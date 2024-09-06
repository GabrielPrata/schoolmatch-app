# SchoolMatch App

Projeto para a Neopav com o front-end desemvolvido em Flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Estrutura do projeto

Todos os arquivos do app se encontram dentro da pasta lib (padrão de aplicações em Flutter)
Dentro da pasta lib, temos de fato a estrutura do aplicativo com mais pastas e subpastas.
Iremos agora definir o que cada pasta irá comportar:<br>
![image](https://github.com/rcsolucoes/rc_mineracao/assets/49907324/4f81362c-7e94-47f6-8a2a-d7716414c0a7)

Na pasta domain, iremos ter mais três subpastas sendo elas: controlleers, models e services. Segue a imagem abaixo:<br>
![image](https://github.com/rcsolucoes/rc_mineracao/assets/49907324/d235b18f-a043-4d34-8e71-cbbe8b5392da)

A pasta domain possui todas as lógicas e regras de negócio da aplição. 
- Dentro de controllers, são os arquivos responsáveis por buscar os dados das models e exibir para os usuários nas telas. (Exemplo:  auth_controller.dart) <br>
- Em services, é aonde a aplicação se comunica com o mundo. Todas as chamadas para a API estão dentro deste diretório. (Exemplo: auth_service.dart) <br>
- Já em models, estão todas as classes da aplicação. Podemos também ter os bancos de dados internos salvos aí dentro. (Exemplo: auth_model.dart) <br>
![image](https://github.com/rcsolucoes/rc_mineracao/assets/49907324/adb3809a-c869-41d4-9649-1f548cfb1abb)

Na pasta UI, teremos 3 subpastas, sendo elas: screens, style e widgets. <br>
![image](https://github.com/rcsolucoes/rc_mineracao/assets/49907324/f82f6e38-0d2c-4d57-9fa2-bc74ac421e8a)<br>
A pasta UI é a responsável por tudo quee está relacionado a interface do aplicativo.
- Em screens, teremos as telas da aplicação (Exemplo: login_screen.dart)
- Widgets, estarão os widgets, que são os componentes do app. Esta pasta pode ser dividida em várias subpastas de acordo com a necessidade (Exemplo: home/home_buttons.dart)
- Style, está a estilização do app. Um bom exemplo é a paleta de cores padrão que pode ser alterada lá.

Em util, ficam as URL's da API e constantes da aplicação. <br>
![image](https://github.com/rcsolucoes/rc_mineracao/assets/49907324/1fb39a05-3ca4-4b50-b42b-8cd7f8c453a2)



