# App ToDo List com Flutter + Supabase

Aplicação de gerenciamento de tarefas (To-Do List) desenvolvida em Flutter, utilizando Supabase como backend e PostgreSQL como banco de dados. O projeto foi construído com arquitetura organizada em camadas, contemplando autenticação de usuários, persistência em nuvem, geração de relatórios em PDF e gerenciamento completo de tarefas.

---

## Funcionalidades

### Autenticação

- Cadastro de usuários
- Login com e-mail e senha
- Autenticação com Google OAuth
- Logout de sessão
- Controle de acesso por usuário autenticado

### Gerenciamento de Tarefas

- Cadastro de tarefas
- Listagem de tarefas
- Edição de tarefas
- Exclusão de tarefas
- Marcação de tarefas como concluídas
- Atualização automática da lista de tarefas
- Isolamento dos dados por usuário autenticado

### Filtros

- Visualização de todas as tarefas
- Filtro de tarefas pendentes
- Filtro de tarefas concluídas

### Relatórios

- Geração de relatório em PDF
- Exportação das tarefas cadastradas

### Persistência de Dados

- Armazenamento em nuvem utilizando Supabase
- Banco de dados PostgreSQL
- Sincronização em tempo real com o backend

### Arquitetura

- Organização em Models
- Organização em Services
- Organização em Controllers
- Organização em Views
- Separação de responsabilidades seguindo boas práticas de desenvolvimento

---

## Tecnologias Utilizadas

- Flutter
- Dart
- Supabase
- PostgreSQL
- OAuth2
- Git
- GitHub
- Flutter PDF
- Flutter Dotenv

---

## Estrutura do Projeto

```text
lib/
├── controllers/
│   └── tarefa_controller.dart
│
├── models/
│   └── tarefa.dart
│
├── services/
│   ├── auth_service.dart
│   ├── database_service.dart
│   ├── pdf_service.dart
│   └── tarefa_service.dart
│
├── views/
│   ├── login_page.dart
│   └── tarefa_page.dart
│
└── main.dart
