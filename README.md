# QR Code Scanner and Generator

O aplicativo **QR Code Scanner and Generator** é um projeto simples desenvolvido com o intuito de aprendizagem. O objetivo principal do app é permitir aos usuários escanear e criar códigos QR, além de salvar o histórico de operações realizadas.

## Funcionalidades

- **Escanear QR Code**: Utilize a câmera do dispositivo para escanear códigos QR.
- **Gerar QR Code**: Crie seus próprios códigos QR a partir de textos ou URLs.
- **Salvar no Histórico**: Todas as operações de escaneamento e geração de QR Codes são salvas no histórico para fácil acesso futuro.

## Arquitetura

O aplicativo foi desenvolvido utilizando a arquitetura MVC:

- **Model**: Representa os dados e a lógica de negócio do aplicativo.
- **View**: Responsável pela interface do usuário e pela apresentação dos dados.
- **Controller**: Atua como um intermediário entre o Model e a View, gerenciando a lógica de fluxo de dados.

## Pacotes Utilizados

Este projeto utiliza diversos pacotes para fornecer funcionalidades específicas:

- **qr_code_scanner**: Utilizado para escanear QR Codes.
- **qr_flutter**: Utilizado para gerar QR Codes.
- **auto_injector**: Para injeção de dependências de forma automática.
- **url_launcher**: Para lançar URLs no navegador ou em outros aplicativos.
- **sqflite**: Para armazenamento local dos dados no dispositivo usando SQLite.
- **fpdart**: Para programação funcional.
- **path_provider**: Para acessar caminhos do sistema de arquivos do dispositivo.
- **path**: Para manipulação de caminhos de arquivos e diretórios.
- **equatable**: Para comparação de objetos de maneira fácil e eficiente.
- **brasil_datetime**: Para manipulação de datas e horas no formato brasileiro.
- **flutter_file_dialog**: Para manipulação de diálogos de arquivos no Flutter.
- **permission_handler**: Para gerenciar permissões no dispositivo.

## Como Executar

Para executar este projeto, siga as etapas abaixo:

1. Clone o repositório para a sua máquina local.
2. Navegue até o diretório do projeto.
3. Execute `flutter pub get` para instalar as dependências.
4. Conecte um dispositivo ou inicie um emulador.
5. Execute `flutter run` para iniciar o aplicativo.