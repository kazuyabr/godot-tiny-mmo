> [!NOTE]
> Site da documentação do repositório: [**slayhorizon.github.io/godot-tiny-mmo/**](https://slayhorizon.github.io/godot-tiny-mmo/)
# Godot Tiny MMO

Uma pequena demonstração de MMORPG baseada na web desenvolvida com Godot Engine 4.4,  
criada sem depender dos nós multiplayer nativos da Godot.

O cliente e o servidor compartilham a mesma base de código, mas graças à sua organização única,  
presets de exportação personalizados permitem que você [**Exporte as builds de Cliente e Servidor separadamente**](https://slayhorizon.github.io/godot-tiny-mmo/#/pages/export),  
mantendo as builds seguras e otimizadas ao excluir componentes desnecessários.

Este projeto contém diferentes tipos de servidores para tentar simular a arquitetura típica de MMOs:  
gateway, world e master server (Veja o [diagrama de Arquitetura de Rede em **#Features**](#features)).

Para documentação e mais detalhes, acesse [**https://slayhorizon.github.io/godot-tiny-mmo/**](https://slayhorizon.github.io/godot-tiny-mmo/).

![project-demo-screenshot](https://github.com/user-attachments/assets/ca606976-fd9d-4a92-a679-1f65cb80513a)
![image](https://github.com/user-attachments/assets/7e21a7e5-4c72-4871-b0cf-6d94f8931bf7)


> [!WARNING]  
> Este projeto está em **estado experimental** e faltam funcionalidades (Veja [**#Features**](#features)).

## Funcionalidades

Funcionalidades atuais e planejadas:

- [X] **Conexão Cliente-Servidor** via `WebSocketMultiplayerPeer`
- [x] **Jogável no navegador web e desktop**
- [x] **Arquitetura de rede** (veja o diagrama abaixo)
- [X] **Sistema de autenticação** via servidor gateway com interface de login
- [x] **Criação de conta** para contas permanentes de jogadores
- [x] **Interface de seleção de servidor** para o jogador escolher entre diferentes servidores
- [x] **Banco de dados QAD** para salvar dados persistentes
- [x] **Login como convidado** para acesso rápido
- [x] **Verificação de versão do jogo** para garantir compatibilidade do cliente
- [x] **Criação de personagem**
- [x] **Sistema básico de classes de RPG** com três classes iniciais: Cavaleiro, Ladino, Mago
- [ ] **Armas** pelo menos uma arma utilizável por classe
- [ ] **Sistema básico de combate**
- [X] **Sincronização de entidades** para jogadores na mesma instância
- [ ] **Interpolação de entidades** para lidar com rubber banding
- [x] **Chat por instância** para comunicação localizada
- [X] **Mapas por instância** com viagem entre diferentes instâncias de mapas
- [x] **Três mapas diferentes:** Mundo, Entrada da Masmorra, Masmorra
- [ ] **Instâncias privadas** para jogadores solo ou pequenos grupos
- [ ] **Anti-cheat no servidor** (validação básica para hacks de velocidade, teleporte, etc.)
- [ ] **NPCs no servidor** (lógica de IA processada no servidor)

Diagrama atual da arquitetura de rede deste demo (sujeito a alterações):
![architecture-diagram-26-10-2024](https://github.com/user-attachments/assets/78b1cce2-b070-4544-8ecd-59784743c7a0)


## Primeiros Passos

Para rodar o projeto, siga estes passos:

1. Abra o projeto no **Godot 4.4**.
2. Vá até a aba Debug e selecione **"Customizable Run Instance..."**.
3. Habilite **Multiple Instances** e defina o número para **4 ou mais**.
4. Em **Feature Tags**, certifique-se de ter:
   - Exatamente **uma** tag "gateway-server".
   - Exatamente **uma** tag "master-server".
   - Exatamente **uma** tag "world-server".
   - Pelo menos **uma ou mais** tags "client".
5. (Opcional) Em **Launch Arguments**:
   - Para servidores, adicione **--headless** para evitar janelas vazias.
   - Para qualquer instância, adicione **--config=caminho_do_arquivo.cfg** para usar um caminho de configuração diferente do padrão.
6. Rode o projeto (Pressione F5).

Exemplo de configuração  
(Mais detalhes na wiki [Como usar "Customize Run Instances..."](https://slayhorizon.github.io/godot-tiny-mmo/#/pages/customize_run_instances):
<img width="1580" alt="debug-screenshot" src="https://github.com/user-attachments/assets/cff4dd67-00f2-4dda-986f-7f0bec0a695e">
  

## Contribuindo

Sinta-se à vontade para fazer um fork do repositório e enviar um pull request se tiver ideias ou melhorias!  
Você também pode abrir uma [**Issue**](https://github.com/SlayHorizon/godot-tiny-mmo-template/issues) para discutir bugs ou sugestões de funcionalidades.


## Créditos
- **Mapas** desenhados por [@d-Cadrius](https://github.com/d-Cadrius).
- **Screenshots** fornecidos por [@WithinAmnesia](https://github.com/WithinAmnesia).
- Também agradecemos a [@Anokolisa](https://anokolisa.itch.io/dungeon-crawler-pixel-art-asset-pack) por permitir o uso de seus assets neste projeto open source!


> Código fonte sob [**Licença MIT**](https://github.com/SlayHorizon/godot-tiny-mmo/blob/main/LICENSE)  
> _Para dúvidas, entre em contato no Discord: `slayhorizon`_
