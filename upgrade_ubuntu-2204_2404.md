# Upgrade do Ubuntu 22.04 (LTS) para Ubuntu 24.04

1. **Atualize o Ubuntu 22.04 completamente** - Abra o terminal e rode 'sudo apt update && sudo apt upgrade -y' e depois 'sudo apt dist-upgrade -y'. É essencial estar 100% atualizado no 22.04 antes de tentar o salto para o 24.04, senão o gerenciador de upgrade nem libera a opção.  
2. **Reinicie o sistema** - Depois das atualizações, reinicie com 'sudo reboot' para garantir que o kernel e os pacotes atualizados fiquem ativos antes de prosseguir.  
3. **Instale o utilitário de upgrade de release** - Rode 'sudo apt install update-manager-core' caso ainda não esteja instalado. É esse pacote que fornece o comando 'do-release-upgrade' usado no próximo passo.  
4. **Verifique se o prompt de release está configurado** - Confira o arquivo '/etc/update-manager/release-upgrades' e garanta que a linha 'Prompt=lts' (ou 'normal', se quiser versões não-LTS) esteja definida. Isso libera a detecção da nova versão LTS.  
5. **Faça backup dos seus dados** - Antes de qualquer upgrade de versão, faça backup de arquivos importantes, configurações (dotfiles) e liste os pacotes instalados com 'apt list --installed > pacotes.txt', só por segurança caso algo dê errado no processo.  
6. **Execute o upgrade de release** - Rode 'sudo do-release-upgrade' no terminal. O utilitário vai baixar os novos pacotes, mostrar o que será removido/adicionado e pedir confirmação em algumas etapas. É um processo que pode levar de 30 minutos a mais de uma hora, dependendo da conexão e da quantidade de pacotes.  
7. **Responda às perguntas durante o processo** - O instalador pode perguntar sobre manter ou substituir arquivos de configuração modificados (geralmente é seguro manter a versão local, 'N', se você personalizou algo) e sobre remover pacotes obsoletos ao final — normalmente pode confirmar com 'sim'.  
8. **Reinicie e confira a versão** - Ao final, o sistema pedirá para reiniciar. Depois de reiniciar, rode 'lsb_release -a' ou 'cat /etc/os-release' para confirmar que já está no Ubuntu 24.04.  

---
- **Observação:**  
Esse é o caminho oficial pelo terminal, funciona tanto no Desktop quanto no Server.  
**Só um detalhe importante:** Se estiver rodando o Desktop, garanta que o Prompt esteja como lts, senão o do-release-upgrade pode não detectar a atualização até o lançamento do primeiro point release (24.04.1), que já saiu há tempo, então não deve ser problema agora.

---
## Atualmente (09.2026) estamos na LTS 26.04, então o Ubuntu 22.04 vai pular para o 26.04 ou vai atualizar para o 24.04?

Não dá para pular direto do 22.04 para o 26.04. O Ubuntu não permite pular versões LTS.  

Ou seja, o processo que passei está correto: o `do-release-upgrade` no seu sistema 22.04 vai te levar para o **24.04**, não para o 26.04. Depois de estar no 24.04, aí sim você faria um segundo upgrade, separado, de 24.04 para 26.04.  

O Ubuntu 26.04 LTS foi lançado em abril de 2026, mas o Canonical só liberou o caminho oficial de atualização a partir do 24.04 para o 26.04 depois do lançamento do primeiro point release, o 26.04.1 — decisão deliberada para dar tempo de corrigir bugs que aparecem depois do lançamento inicial, especialmente relevante para quem depende da estabilidade do LTS.  

- **Resumindo o caminho completo:**  

1. **22.04 → 24.04** (o passo a passo acima)
2. Depois, com calma, **24.04 → 26.04** (esse já está liberado pelo caminho padrão, já que o 26.04.1 saiu)

---

## Atualização via SSH ou local

Dá para fazer via SSH, o `do-release-upgrade` foi feito pensando nisso, mas com alguns cuidados extras porque a rede é reiniciada durante o processo:  

- O utilitário detecta automaticamente que você está numa sessão SSH e abre um **listener de backup na porta 1022**, então se a conexão principal cair, você consegue reconectar por ali (`ssh -p 1022 usuario@host`).  
- Mesmo assim, **não feche o terminal nem deixe a sessão cair por inatividade** durante o processo. Se usar algo como `tmux` ou `screen` antes de iniciar o upgrade, você fica protegido caso a conexão SSH em si caia (o processo continua rodando dentro da sessão).  
- Tenha um **plano B de acesso** caso algo dê errado de verdade (rede não sobe de novo, por exemplo): acesso físico à máquina, IPMI/iDRAC se for servidor, ou KVM remoto.  
- Evite rodar por SSH se a própria atualização for a causa possível de mudanças na configuração de rede (o seu caso é justamente um bug do NetworkManager, então há uma chance, ainda que pequena, de a interface de rede se comportar diferente após o reboot final).  

---

## Processo de upgrade, somente comandos
```bash
sudo apt update && sudo apt -y upgrade
```
```bash
sudo apt dist-upgrade -y
```
```bash
sudo apt -f -y install && sudo apt -f -y autoremove && sudo apt clean && sudo apt autoclean
```
```bash
sudo reboot
```
```bash
sudo apt install update-manager-core
```
```bash
sudo sed -i 's/Prompt=.*/Prompt=lts/' /etc/update-manager/release-upgrades
```
```bash
apt list --installed > ~/pacotes_ubuntu2204.txt
```
- **Via local, sem acesso remoto SSH e indo para um terminal em tty3:**
```bash
sudo do-release-upgrade
```
