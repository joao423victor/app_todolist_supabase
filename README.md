# App ToDo List com Flutter + Supabase

Aplicação de lista de tarefas desenvolvida em Flutter, com persistência de dados em nuvem utilizando Supabase e arquitetura organizada em camadas.

## Funcionalidades

- Cadastro de usuários
- Login com e-mail e senha
- Autenticação com Google OAuth
- Logout de sessão
- Cadastro de tarefas
- Listagem de tarefas por usuário autenticado
- Edição de tarefas
- Exclusão de tarefas
- Marcação de tarefas como concluídas
- Persistência de dados no Supabase
- Geração de relatório em PDF
- Separação da lógica em controllers, models, services e views

## Tecnologias utilizadas

- Flutter
- Dart
- Supabase
- PostgreSQL
- OAuth2
- Git/GitHub
- Pacotes Flutter para geração de PDF

## Estrutura do projeto

```text
lib/
├── controllers/
│   └── tarefa_controller.dart
├── models/
│   └── tarefa.dart
├── services/
│   ├── auth_service.dart
│   ├── database_service.dart
│   ├── pdf_service.dart
│   └── tarefa_service.dart
├── views/
│   ├── login_page.dart
│   └── tarefa_page.dart
└── main.dart
