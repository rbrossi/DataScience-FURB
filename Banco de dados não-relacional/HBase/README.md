# HBASE

#### Inicializando


```python
docker pull dajobe/hbase
docker run --name hbase-furb dajobe/hbase
docker cp italians.txt hbase-furb:/tmp
docker exec -it hbase-furb /bin/bash
hbase shell
```

1) Crie a tabela com 2 famílias de colunas
 - personal-data
 - professional-data


```python
create 'italians', 'personal-data', 'professional-data'
```

2) Importe o arquivo via linha de comando


```python
# cat /tmp/italians.txt
put 'italians', '1', 'personal-data:name',  'Paolo Sorrentino'
put 'italians', '1', 'personal-data:city',  'Verona'
put 'italians', '1', 'professional-data:role',  'Gestao Comercial'
put 'italians', '1', 'professional-data:salary',  '2394'
put 'italians', '2', 'personal-data:name',  'Domenico Barbieri'
put 'italians', '2', 'personal-data:city',  'Padua'
put 'italians', '2', 'professional-data:role',  'Psicopedagogia'
put 'italians', '2', 'professional-data:salary',  '11890'
put 'italians', '3', 'personal-data:name',  'Maria Parisi'
put 'italians', '3', 'personal-data:city',  'Taranto'
put 'italians', '3', 'professional-data:role',  'Optometria'
put 'italians', '3', 'professional-data:salary',  '20960'
put 'italians', '4', 'personal-data:name',  'Silvia Gallo'
put 'italians', '4', 'personal-data:city',  'Rome'
put 'italians', '4', 'professional-data:role',  'Engenharia Industrial Madeireira'
put 'italians', '4', 'professional-data:salary',  '16770'
put 'italians', '5', 'personal-data:name',  'Rosa Donati'
put 'italians', '5', 'personal-data:city',  'Palermo'
put 'italians', '5', 'professional-data:role',  'Mecatronica Industrial'
put 'italians', '5', 'professional-data:salary',  '7037'
put 'italians', '6', 'personal-data:name',  'Simone Lombardo'
put 'italians', '6', 'personal-data:city',  'Trieste'
put 'italians', '6', 'professional-data:role',  'Biotecnologia e Bioquimica'
put 'italians', '6', 'professional-data:salary',  '11395'
put 'italians', '7', 'personal-data:name',  'Barbara Ferretti'
put 'italians', '7', 'personal-data:city',  'Florence'
put 'italians', '7', 'professional-data:role',  'Libras'
put 'italians', '7', 'professional-data:salary',  '18627'
put 'italians', '8', 'personal-data:name',  'Simone Ferrara'
put 'italians', '8', 'personal-data:city',  'Milan'
put 'italians', '8', 'professional-data:role',  'Engenharia de Minas'
put 'italians', '8', 'professional-data:salary',  '8129'
put 'italians', '9', 'personal-data:name',  'Vincenzo Giordano'
put 'italians', '9', 'personal-data:city',  'Messina'
put 'italians', '9', 'professional-data:role',  'Marketing'
put 'italians', '9', 'professional-data:salary',  '9919'
put 'italians', '10', 'personal-data:name',  'Giovanna Caputo'
put 'italians', '10', 'personal-data:city',  'Milan'
put 'italians', '10', 'professional-data:role',  'Comunicacao Institucional'
put 'italians', '10', 'professional-data:salary',  '9470'
```

#### Executar as seguintes operações:

1) Adicione mais 2 italianos mantendo adicionando informações como data de nascimento nas informações pessoais e um atributo de anos de experiência nas informações profissionais;


```python
put 'italians', '11', 'personal-data:name',  'Rafael Rossi'
put 'italians', '11', 'personal-data:city',  'Roma'
put 'italians', '11', 'personal-data:datebirth',  '1995-10-16'
put 'italians', '11', 'professional-data:role',  'Computing'
put 'italians', '11', 'professional-data:salary',  '9555'
put 'italians', '11', 'professional-data:yearsexperience',  '10'

put 'italians', '12', 'personal-data:name',  'Giuseppe Ferrari'
put 'italians', '12', 'personal-data:city',  'Milan'
put 'italians', '12', 'personal-data:datebirth',  '1968-10-10'
put 'italians', '12', 'professional-data:role',  'Libras'
put 'italians', '12', 'professional-data:salary',  '912367'
put 'italians', '11', 'professional-data:yearsexperience',  '12'
```

2) Adicione o controle de 5 versões na tabela de dados pessoais


```python
alter 'italians', {NAME => 'personal-data',VERSIONS =>  '5'}
```

3) Faça 5 alterações em um dos italianos


```python
put 'italians', '12', 'personal-data:name',  'Giuseppe D. Ferrari'
put 'italians', '12', 'personal-data:city',  'Veneza'
put 'italians', '11', 'personal-data:datebirth',  '1968-10-11'
put 'italians', '12', 'professional-data:role',  'Libras'
put 'italians', '12', 'professional-data:salary',  '100000'
put 'italians', '11', 'professional-data:yearsexperience',  '20'
```

4) Com o operador get, verifique como o HBase armazenou o histórico.


```python
get 'italians', 12
```

5) Utilize o scan para mostrar apenas o nome e profissão dos italianos.


```python
scan 'italians', {COLUMNS => ['personal-data:name', 'professional-data:role']}
```

6) Apague os italianos com row id ímpar


```python
deleteall 'italians', '1'
deleteall 'italians', '3'
deleteall 'italians', '5'
deleteall 'italians', '7'
deleteall 'italians', '9'
deleteall 'italians', '11'
```

7) Crie um contador de idade 55 para o italiano de row id 5


```python
incr 'italians', '5', 'personal-data:age', 55
```

8) Incremente a idade do italiano em 1


```python
incr 'italians', '5', 'personal-data:age'
```
