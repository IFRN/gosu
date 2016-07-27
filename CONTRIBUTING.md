## Como contribuir?

Para adicionar um novo projeto, siga as seguintes instruções:

- _Fork_ este repositório
- _Clone_ seu repositório na sua máquina

  ```sh
  git clone https://github.com/{{seu usuário}}/gosu-exemplos.git
  ```
  
- Navegue até o período em que seu projeto foi desenvolvido
 
  ```sh
  cd gosu-exemplos/20151 # onde 20151 é o período 2015.1
  ```
  
- Agora você só precisa adicionar seu projeto como um **submódulo**
  
  ```sh
  git submodule add https://github.com/{{seu usuário}}/{{seu projeto}}
  ```
  
- O _git_ se encarrega de adicionar os arquivos ao _commit_, mas por via das dúvidas
 
 ```sh
 git add --all
 ```
 
- Agora você só precisa enviar o _commit_
 
 ```sh
 git commit -m "Adiciona {{periodo}}/{{seu projeto}}"
 git push
 ```
 
- Tudo pronto, acesse seu GitHub e envie a _Pull Request_

### O que é um submódulo?

Para mais informações sobre **submódulos** do _git_, veja a [documentação em pt-br](https://git-scm.com/book/pt-br/v1/Ferramentas-do-Git-Subm%C3%B3dulos).
