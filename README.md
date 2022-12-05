# manOS - Process Killer

Nosso projeto é um sistema que mata processos maliciosos voltado para a área das escolas públicas do ensino médio;
ele irá identificar os processos através de uma consulta feita na lista de processos atuais da maquina,
e se o processo estiver fora da lista de processos permitidos, ele automaticamente os eliminará; <Br>
    
Ele tambem consegue identificar em qual sistema operacional a maquina esta trabalhando(Windows ou Linux); <br>
    
Ele coleta dados dinâmicos e estáticos sobre os processos da maquina; <br>
    
Dentro deste repositório estão as informações necessárias para a instalação e uso do nosso sistema; <br>
clicando no link :<link>"https://github.com/RED-WAY/MANOInstallation"</link> você terá acesso ao script do assistente de instalação;

esse assistente que por sua vez irá verificar se a maquina do cliente tem os recursos e programas necessários para o uso do nosso sistema, 
se caso não tenha, o próprio assistente esta encarregado de baixa-los e realizar a instalação dos mesmos

Exemplos de dados dinâmicos que o nosso sistema retorna:
<pre>
    private Double cpuUse;
    private Double ramUse;
    private Integer idMachine;
</pre>
    
 
