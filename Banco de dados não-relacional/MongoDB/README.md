
### Exercício 1: Aquecendo com os pets
Inicie com os seguintes comandos:


```python
from pymongo import MongoClient
```


```python
use petshop

db.pets.insert({name: "Mike", species: "Hamster"})
db.pets.insert({name: "Dolly", species: "Peixe"})
db.pets.insert({name: "Kilha", species: "Gato"})
db.pets.insert({name: "Mike", species: "Cachorro"})
db.pets.insert({name: "Sally", species: "Cachorro"})
db.pets.insert({name: "Chuck", species: "Gato"})
```


```python
db = MongoClient()
```


```python
petshop = db['petshop']
pets = petshop['pets']
```


```python
pets.insert_one({"name": "Mike", "species": "Hamster"})
pets.insert_one({"name": "Dolly", "species": "Peixe"})
pets.insert_one({"name": "Kilha", "species": "Gato"})
pets.insert_one({"name": "Mike", "species": "Cachorro"})
pets.insert_one({"name": "Sally", "species": "Cachorro"})
pets.insert_one({"name": "Chuck", "species": "Gato"})
```




    <pymongo.results.InsertOneResult at 0x222dfb312c8>



1) Adicione outro Peixe e um Hamster com nome Frodo


```python
pets.insert({"name": "Frodo", "species": "Peixe"})
pets.insert({"name": "Frodo", "species": "Hamster"})
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:1: DeprecationWarning: insert is deprecated. Use insert_one or insert_many instead.
      """Entry point for launching an IPython kernel.
    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: insert is deprecated. Use insert_one or insert_many instead.
      
    




    ObjectId('5e8684a1de8bc07c0d5df442')



2) Faça uma contagem dos pets na coleção


```python
pets.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:1: DeprecationWarning: count is deprecated. Use estimated_document_count or count_documents instead. Please note that $where must be replaced by $expr, $near must be replaced by $geoWithin with $center, and $nearSphere must be replaced by $geoWithin with $centerSphere
      """Entry point for launching an IPython kernel.
    




    8



3) Retorne apenas um elemento o método prático possível



```python
pets.find_one()
```




    {'_id': ObjectId('5e868410de8bc07c0d5df43a'),
     'name': 'Mike',
     'species': 'Hamster'}



4) Identifique o ID para o Gato Kilha


```python
pets.find_one({"name": "Kilha"})
```




    {'_id': ObjectId('5e868410de8bc07c0d5df43c'),
     'name': 'Kilha',
     'species': 'Gato'}



5) Faça uma busca pelo ID e traga o Hamster Mike


```python
id_hamster = pets.find_one({"name": "Mike", "species": "Hamster"}, {'_id'})
id_hamster
```




    {'_id': ObjectId('5e868410de8bc07c0d5df43a')}




```python
pets.find_one(id_hamster)
```




    {'_id': ObjectId('5e868410de8bc07c0d5df43a'),
     'name': 'Mike',
     'species': 'Hamster'}



6) Use o find para trazer todos os hamsters


```python
for pet in pets.find({"species": "Hamster"}):
    print(pet)
```

    {'_id': ObjectId('5e868410de8bc07c0d5df43a'), 'name': 'Mike', 'species': 'Hamster'}
    {'_id': ObjectId('5e8684a1de8bc07c0d5df442'), 'name': 'Frodo', 'species': 'Hamster'}
    

7) Use o find para listar todos os pets com nome Mike


```python
for pet in pets.find({"name": "Mike"}):
    print(pet)
```

    {'_id': ObjectId('5e868410de8bc07c0d5df43a'), 'name': 'Mike', 'species': 'Hamster'}
    {'_id': ObjectId('5e868410de8bc07c0d5df43d'), 'name': 'Mike', 'species': 'Cachorro'}
    

8) Liste apenas o documento que é um Cachorro chamado Mike


```python
for pet in pets.find({"name": "Mike", "species": "Cachorro"}):
    print(pet)
```

    {'_id': ObjectId('5e868410de8bc07c0d5df43d'), 'name': 'Mike', 'species': 'Cachorro'}
    

### Exercício 2: Mama mia!


```python
italians = client['test']['italians']

```


```python
italians.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:1: DeprecationWarning: count is deprecated. Use estimated_document_count or count_documents instead. Please note that $where must be replaced by $expr, $near must be replaced by $geoWithin with $center, and $nearSphere must be replaced by $geoWithin with $centerSphere
      """Entry point for launching an IPython kernel.
    




    9987



1) Liste/Conte todas as pessoas que tem exatamente 99 anos. Você pode usar um count para indicar a quantidade


```python
p = italians.find({"age": 99})
p.count()

```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    0



2) Identifique quantas pessoas são elegíveis atendimento prioritário (pessoas com mais de 65 anos)


```python
p = italians.find({"age": {"$gt": 65}})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    1714



3) Identifique todos os jovens (pessoas entre 12 a 18 anos).


```python
p = italians.find({"age": {"$gt": 12, "$lt": 18}})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    647



4) Identifique quantas pessoas tem gatos, quantas tem cachorro e quantas não tem nenhum dos dois


```python
cats = italians.find({'cat': {"$exists": True}})
dogs = italians.find({'dog': {"$exists": True}})
not_cat_dog = italians.find({"$and": [{'cat': {"$exists": False}}, {'dog': {"$exists": False}}]})

print("Pessoas que tem gatos: ", cats.count())
print("Pessoas que tem cachorros: ", dogs.count())
print("Pessoas que não tem nem gato nem cahorro: ", not_cat_dog.count())
```

    Pessoas que tem gatos:  6024
    Pessoas que tem cachorros:  4039
    Pessoas que não tem nem gato nem cahorro:  2384
    

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:5: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      """
    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:6: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:7: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      import sys
    

5) Liste/Conte todas as pessoas acima de 60 anos que tenham gato


```python
p = italians.find({"$and": [{"age": {"$gt": 60}}, {'cat': {"$exists": True}}]})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    1399



6) Liste/Conte todos os jovens com cachorro


```python
p = italians.find({"$and": [{"age": {"$lt": 18}}, {'dog': {"$exists": True}}]})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    904



7) Utilizando o $where, liste todas as pessoas que tem gato e cachorro


```python
p = italians.find({"$and": [{"$where": "this.cat != undefined"}, {"$where": "this.dog != undefined"}]})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    2460



8) Liste todas as pessoas mais novas que seus respectivos gatos.



```python
p = italians.find({"$and": [{"$where": "this.cat != undefined"}, {"$where": "this.age < this.cat.age"}]})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    683



9) Liste as pessoas que tem o mesmo nome que seu bichano (gatou ou cachorro)



```python
p = italians.find({"$and": [{"$where": "this.cat != null"}, {"$where": "this.firstname == this.cat.name"}]}, {"$and": [{"$where": "this.dog != null"}, {"$where": "this.firstname == this.dog.name"}]})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    67



10) Projete apenas o nome e sobrenome das pessoas com tipo de sangue de fator RH negativo



```python
p = italians.find({"bloodType" : {"$exists":  "-"}}, {"firstname" : True, "surname": True})
p.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use Collection.count_documents instead.
      
    




    9987



11) Projete apenas os animais dos italianos. Devem ser listados os animais com nome e idade. Não mostre o identificado do mongo (ObjectId)



```python
p = italians.find({}, {"_id": False, "dog" : True, "cat": True})
```

12) Quais são as 5 pessoas mais velhas com sobrenome Rossi?



```python
list_p = italians.find({"surname": "Rossi"}, {"firtname": 1, "age": 1}).sort("age", -1).limit(5)

for p in list_p:
    print(p)
```

    {'_id': ObjectId('5e5aa453976c0669e4010eb0'), 'age': 79.0}
    {'_id': ObjectId('5e5aa464976c0669e401254f'), 'age': 77.0}
    {'_id': ObjectId('5e5aa464976c0669e4012568'), 'age': 75.0}
    {'_id': ObjectId('5e5aa46b976c0669e4012e22'), 'age': 75.0}
    {'_id': ObjectId('5e5aa456976c0669e40112ef'), 'age': 74.0}
    

13) Crie um italiano que tenha um leão como animal de estimação. Associe um nome e idade ao bichano



```python
italians.insert_one({
    'firstname': 'Rafael',
    'surname': 'Rossi',
    'cat': {'name': 'Mimi', 'age': 2}}
)
```




    <pymongo.results.InsertOneResult at 0x222e026af48>



14) Infelizmente o Leão comeu o italiano. Remova essa pessoa usando o Id.



```python
p = italians.find_one({'firstname': 'Rafael'}, {'_id'})
italians.delete_one(p)
```




    <pymongo.results.DeleteResult at 0x222dfb60bc8>



15) Passou um ano. Atualize a idade de todos os italianos e dos bichanos em 1.



```python
italians.update_many({}, {"$inc": {"age": 1}})
italians.update_many({}, {"$inc": {"cat.age": 1}})
```




    <pymongo.results.UpdateResult at 0x222dfb605c8>



16) O Corona Vírus chegou na Itália e misteriosamente atingiu pessoas somente com gatos e de 66 anos. Remova esses italianos.



```python
italians.remove({"$and": [{"age": 66}, {"cat": {"$exists": True}}]})
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:1: DeprecationWarning: remove is deprecated. Use delete_one or delete_many instead.
      """Entry point for launching an IPython kernel.
    




    {'n': 125, 'ok': 1.0}



### Exercício 3: Stockbrokers


```python
stocks = db['test']['stocks']
stocks.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use estimated_document_count or count_documents instead. Please note that $where must be replaced by $expr, $near must be replaced by $geoWithin with $center, and $nearSphere must be replaced by $geoWithin with $centerSphere
      
    




    6756



1) Liste as ações com profit acima de 0.5 (limite a 10 o resultado)



```python
stock_list = stocks.find({
    "Profit Margin" : {"$gt": 0.5}
}).limit(10)

for s in stock_list:
    print(s,"\n")
```

    {'_id': ObjectId('52853800bb1177ca391c180f'), 'Ticker': 'AB', 'Profit Margin': 0.896, 'Institutional Ownership': 0.368, 'EPS growth past 5 years': -0.348, 'Total Debt/Equity': 0, 'Return on Assets': 0.086, 'Sector': 'Financial', 'P/S': 13.25, 'Change from Open': 0.0047, 'Performance (YTD)': 0.3227, 'Performance (Week)': -0.0302, 'Insider Transactions': 0.5973, 'P/B': 1.4, 'EPS growth quarter over quarter': 2.391, 'Payout Ratio': 1.75, 'Performance (Quarter)': 0.0929, 'Forward P/E': 12.58, 'P/E': 15.82, '200-Day Simple Moving Average': 0.0159, 'Shares Outstanding': 92.26, 'Earnings Date': datetime.datetime(2013, 10, 24, 12, 30), '52-Week High': -0.1859, 'Change': -0.0009, 'Analyst Recom': 3, 'Volatility (Week)': 0.0264, 'Country': 'USA', 'Return on Equity': 0.087, '50-Day Low': 0.123, 'Price': 21.5, '50-Day High': -0.0574, 'Return on Investment': 0.033, 'Shares Float': 86.66, 'Dividend Yield': 0.0743, 'EPS growth next 5 years': 0.08, 'Industry': 'Asset Management', 'Beta': 1.63, 'Operating Margin': 1, 'EPS (ttm)': 1.36, 'PEG': 1.98, 'Float Short': 0.0253, '52-Week Low': 0.4687, 'Average True Range': 0.59, 'EPS growth next year': 0.0654, 'Sales growth past 5 years': -0.298, 'Company': 'AllianceBernstein Holding L.P.', 'Gap': -0.0056, 'Relative Volume': 0.63, 'Volatility (Month)': 0.0298, 'Market Cap': 1985.39, 'Volume': 199677, 'Short Ratio': 6.3, 'Performance (Half Year)': -0.1159, 'Relative Strength Index (14)': 50.05, 'Insider Ownership': 0.002, '20-Day Simple Moving Average': -0.007, 'Performance (Month)': 0.0847, 'P/Free Cash Flow': 93.21, 'Institutional Transactions': 0.0818, 'Performance (Year)': 0.3884, 'LT Debt/Equity': 0, 'Average Volume': 348.08, 'EPS growth this year': 1.567, '50-Day Simple Moving Average': 0.0458} 
    
    {'_id': ObjectId('52853801bb1177ca391c1895'), 'Ticker': 'AGNC', 'Profit Margin': 0.972, 'Institutional Ownership': 0.481, 'EPS growth past 5 years': -0.0107, 'Total Debt/Equity': 8.56, 'Return on Assets': 0.022, 'Sector': 'Financial', 'P/S': 3.77, 'Change from Open': 0.0102, 'Performance (YTD)': -0.1652, 'Performance (Week)': -0.017, 'Insider Transactions': 0.4931, 'P/B': 0.86, 'EPS growth quarter over quarter': -8.2, 'Payout Ratio': 0.79, 'Performance (Quarter)': -0.0083, 'Forward P/E': 7.64, 'P/E': 3.68, '200-Day Simple Moving Average': -0.1282, 'Shares Outstanding': 390.6, 'Earnings Date': datetime.datetime(2013, 10, 28, 20, 30), '52-Week High': -0.2938, 'P/Cash': 3.93, 'Change': 0.0131, 'Analyst Recom': 2.6, 'Volatility (Week)': 0.0268, 'Country': 'USA', 'Return on Equity': 0.205, '50-Day Low': 0.0695, 'Price': 21.71, '50-Day High': -0.1066, 'Return on Investment': 0.015, 'Shares Float': 383.97, 'Dividend Yield': 0.1493, 'EPS growth next 5 years': 0.035, 'Industry': 'REIT - Residential', 'Beta': 0.51, 'Sales growth quarter over quarter': 0.073, 'Operating Margin': 0.67, 'EPS (ttm)': 5.82, 'PEG': 1.05, 'Float Short': 0.0311, '52-Week Low': 0.1117, 'Average True Range': 0.52, 'EPS growth next year': -0.3603, 'Company': 'American Capital Agency Corp.', 'Gap': 0.0028, 'Relative Volume': 0.71, 'Volatility (Month)': 0.02, 'Market Cap': 8370.56, 'Volume': 4576064, 'Gross Margin': 0.746, 'Short Ratio': 1.69, 'Performance (Half Year)': -0.2136, 'Relative Strength Index (14)': 43.53, 'Insider Ownership': 0.003, '20-Day Simple Moving Average': -0.0318, 'Performance (Month)': -0.042, 'Institutional Transactions': 0.0077, 'Performance (Year)': -0.1503, 'LT Debt/Equity': 0, 'Average Volume': 7072.83, 'EPS growth this year': -0.169, '50-Day Simple Moving Average': -0.0376} 
    
    {'_id': ObjectId('52853801bb1177ca391c1950'), 'Ticker': 'ARCC', 'Profit Margin': 0.654, 'Institutional Ownership': 0.513, 'EPS growth past 5 years': 0.105, 'Total Debt/Equity': 0.59, 'Return on Assets': 0.08, 'Sector': 'Financial', 'P/S': 5.87, 'Change from Open': 0.0105, 'Performance (YTD)': 0.0805, 'Performance (Week)': 0.0023, 'P/B': 1.08, 'EPS growth quarter over quarter': 0.22, 'Payout Ratio': 0.714, 'Performance (Quarter)': 0.0548, 'Forward P/E': 10.69, 'P/E': 8.32, '200-Day Simple Moving Average': 0.046, 'Shares Outstanding': 266.17, 'Earnings Date': datetime.datetime(2013, 11, 5, 13, 30), '52-Week High': -0.0014, 'P/Cash': 46.93, 'Change': 0.0082, 'Analyst Recom': 2, 'Volatility (Week)': 0.0129, 'Country': 'USA', 'Return on Equity': 0.13, '50-Day Low': 0.0527, 'Price': 17.86, '50-Day High': -0.0014, 'Return on Investment': 0.056, 'Shares Float': 279.11, 'Dividend Yield': 0.0858, 'EPS growth next 5 years': 0.08, 'Industry': 'Diversified Investments', 'Beta': 1.62, 'Sales growth quarter over quarter': 0.16, 'Operating Margin': 0.485, 'EPS (ttm)': 2.13, 'PEG': 1.04, 'Float Short': 0.0146, '52-Week Low': 0.2192, 'Average True Range': 0.21, 'EPS growth next year': 0.0209, 'Sales growth past 5 years': 0.317, 'Company': 'Ares Capital Corporation', 'Gap': -0.0023, 'Relative Volume': 0.68, 'Volatility (Month)': 0.0109, 'Market Cap': 4716.6, 'Volume': 938330, 'Gross Margin': 0.528, 'Short Ratio': 2.68, 'Performance (Half Year)': 0.0267, 'Relative Strength Index (14)': 61.2, '20-Day Simple Moving Average': 0.0211, 'Performance (Month)': 0.0381, 'Institutional Transactions': 0.0183, 'Performance (Year)': 0.1574, 'LT Debt/Equity': 0, 'Average Volume': 1522.64, 'EPS growth this year': 0.417, '50-Day Simple Moving Average': 0.0272} 
    
    {'_id': ObjectId('52853801bb1177ca391c195a'), 'Ticker': 'ARI', 'Profit Margin': 0.576, 'Institutional Ownership': 0.631, 'EPS growth past 5 years': 0.1829, 'Total Debt/Equity': 0.28, 'Return on Assets': 0.046, 'Sector': 'Financial', 'P/S': 9.35, 'Change from Open': 0.0214, 'Performance (YTD)': 0.0803, 'Performance (Week)': -0.0055, 'Insider Transactions': -0.0353, 'P/B': 0.89, 'EPS growth quarter over quarter': -0.413, 'Payout Ratio': 1.159, 'Performance (Quarter)': 0.0861, 'Forward P/E': 9.57, 'P/E': 11.88, '200-Day Simple Moving Average': 0.0497, 'Shares Outstanding': 37.37, 'Earnings Date': datetime.datetime(2013, 11, 4, 21, 30), '52-Week High': -0.0404, 'P/Cash': 3.88, 'Change': 0.024, 'Analyst Recom': 2.1, 'Volatility (Week)': 0.0135, 'Country': 'USA', 'Return on Equity': 0.064, '50-Day Low': 0.1598, 'Price': 16.67, '50-Day High': 0.0109, 'Return on Investment': 0.044, 'Shares Float': 36.7, 'Dividend Yield': 0.0983, 'EPS growth next 5 years': 0.025, 'Industry': 'REIT - Diversified', 'Beta': 0.55, 'Sales growth quarter over quarter': 0.309, 'Operating Margin': 0.682, 'EPS (ttm)': 1.37, 'PEG': 4.75, 'Float Short': 0.0182, '52-Week Low': 0.2179, 'Average True Range': 0.24, 'EPS growth next year': 0.1739, 'Company': 'Apollo Commercial Real Estate Finance, Inc.', 'Gap': 0.0025, 'Relative Volume': 1.48, 'Volatility (Month)': 0.0152, 'Market Cap': 608.45, 'Volume': 299352, 'Gross Margin': 0.919, 'Short Ratio': 3.01, 'Performance (Half Year)': -0.0502, 'Relative Strength Index (14)': 68.71, 'Insider Ownership': 0.004, '20-Day Simple Moving Average': 0.0331, 'Performance (Month)': 0.0376, 'P/Free Cash Flow': 126.76, 'Institutional Transactions': 0.0318, 'Performance (Year)': 0.1259, 'LT Debt/Equity': 0.28, 'Average Volume': 222.35, 'EPS growth this year': 0.193, '50-Day Simple Moving Average': 0.0673} 
    
    {'_id': ObjectId('52853801bb1177ca391c1968'), 'Ticker': 'ARR', 'Profit Margin': 0.848, 'Institutional Ownership': 0.318, 'EPS growth past 5 years': 0.813, 'Total Debt/Equity': 8.92, 'Return on Assets': 0.031, 'Sector': 'Financial', 'P/S': 1.7, 'Change from Open': 0.0223, 'Performance (YTD)': -0.2821, 'Performance (Week)': -0.0025, 'Insider Transactions': 0.2313, 'P/B': 0.68, 'Payout Ratio': 0.474, 'Performance (Quarter)': -0.0195, 'Forward P/E': 6.79, 'P/E': 1.88, '200-Day Simple Moving Average': -0.1454, 'Shares Outstanding': 372.59, 'Earnings Date': datetime.datetime(2013, 10, 28, 4, 0), '52-Week High': -0.3453, 'P/Cash': 1.87, 'Change': 0.0249, 'Analyst Recom': 2.6, 'Volatility (Week)': 0.024, 'Country': 'USA', 'Return on Equity': 0.308, '50-Day Low': 0.0728, 'Price': 4.12, '50-Day High': -0.0678, 'Return on Investment': 0.011, 'Shares Float': 366.32, 'Dividend Yield': 0.1493, 'EPS growth next 5 years': -0.049, 'Industry': 'REIT - Residential', 'Beta': 0.3, 'Operating Margin': 0.858, 'EPS (ttm)': 2.14, 'Float Short': 0.0415, '52-Week Low': 0.1495, 'Average True Range': 0.09, 'EPS growth next year': -0.0878, 'Company': 'ARMOUR Residential REIT, Inc.', 'Gap': 0.0025, 'Relative Volume': 1.37, 'Volatility (Month)': 0.0218, 'Market Cap': 1497.82, 'Volume': 6608855, 'Short Ratio': 2.87, 'Performance (Half Year)': -0.2651, 'Relative Strength Index (14)': 51.26, 'Insider Ownership': 0.002, '20-Day Simple Moving Average': -0.0024, 'Performance (Month)': -0.0099, 'P/Free Cash Flow': 10.46, 'Institutional Transactions': 0.0016, 'Performance (Year)': -0.286, 'LT Debt/Equity': 0, 'Average Volume': 5299, 'EPS growth this year': 7.533, '50-Day Simple Moving Average': 0.0048} 
    
    {'_id': ObjectId('52853801bb1177ca391c1998'), 'Ticker': 'ATHL', 'Profit Margin': 0.732, 'Institutional Ownership': 0.753, 'EPS growth past 5 years': 0, 'Total Debt/Equity': 1.81, 'Current Ratio': 0.5, 'Return on Assets': 0.218, 'Sector': 'Basic Materials', 'P/S': 10.42, 'Change from Open': 0.0088, 'Performance (YTD)': 0.1851, 'Performance (Week)': 0.1049, 'Quick Ratio': 0.5, 'Insider Transactions': -0.2682, 'P/B': 7.24, 'EPS growth quarter over quarter': -0.566, 'Payout Ratio': 0, 'Performance (Quarter)': 0.2007, 'Forward P/E': 27.38, 'P/E': 28.16, '200-Day Simple Moving Average': 0.0877, 'Shares Outstanding': 66.34, 'Earnings Date': datetime.datetime(2013, 11, 11, 21, 30), '52-Week High': -0.0439, 'P/Cash': 866.67, 'Change': 0.0126, 'Analyst Recom': 2.3, 'Volatility (Week)': 0.0678, 'Country': 'USA', 'Return on Equity': 0.528, '50-Day Low': 0.2479, 'Price': 33.07, '50-Day High': -0.0439, 'Return on Investment': 0.08, 'Shares Float': 76.13, 'EPS growth next 5 years': 0.5, 'Industry': 'Independent Oil & Gas', 'Sales growth quarter over quarter': 0.964, 'Operating Margin': 0.394, 'EPS (ttm)': 1.16, 'PEG': 0.56, 'Float Short': 0.0046, '52-Week Low': 0.3097, 'Average True Range': 1.53, 'EPS growth next year': 0.6013, 'Company': 'Athlon Energy Inc.', 'Gap': 0.0037, 'Relative Volume': 0.59, 'Volatility (Month)': 0.0464, 'Market Cap': 2166.66, 'Volume': 177265, 'Gross Margin': 0.791, 'Short Ratio': 1.07, 'Relative Strength Index (14)': 56.58, 'Insider Ownership': 0.09, '20-Day Simple Moving Average': 0.0373, 'Performance (Month)': 0.0102, 'LT Debt/Equity': 1.81, 'Average Volume': 330.36, 'EPS growth this year': 0, '50-Day Simple Moving Average': 0.0476} 
    
    {'_id': ObjectId('52853801bb1177ca391c19f6'), 'Ticker': 'AYR', 'Profit Margin': 0.548, 'Institutional Ownership': 0.745, 'EPS growth past 5 years': -0.228, 'Total Debt/Equity': 2.08, 'Return on Assets': 0.066, 'Sector': 'Services', 'P/S': 1.92, 'Change from Open': 0.0058, 'Performance (YTD)': 0.5577, 'Performance (Week)': -0.0032, 'Insider Transactions': -0.0052, 'P/B': 0.83, 'EPS growth quarter over quarter': -0.656, 'Payout Ratio': 0.123, 'Performance (Quarter)': 0.1566, 'Forward P/E': 10.45, 'P/E': 126.07, '200-Day Simple Moving Average': 0.2063, 'Shares Outstanding': 70.35, 'Earnings Date': datetime.datetime(2013, 10, 31, 12, 30), '52-Week High': -0.0257, 'P/Cash': 5.58, 'Change': 0.0042, 'Analyst Recom': 2.6, 'Volatility (Week)': 0.0202, 'Country': 'USA', 'Return on Equity': 0.257, '50-Day Low': 0.1304, 'Price': 18.99, '50-Day High': -0.0257, 'Return on Investment': 0.007, 'Shares Float': 64.67, 'Dividend Yield': 0.0349, 'EPS growth next 5 years': 0.292, 'Industry': 'Rental & Leasing Services', 'Beta': 2.07, 'Sales growth quarter over quarter': -0.016, 'Operating Margin': 0.457, 'EPS (ttm)': 0.15, 'PEG': 4.32, 'Float Short': 0.0327, '52-Week Low': 0.8106, 'Average True Range': 0.37, 'EPS growth next year': 0.4873, 'Sales growth past 5 years': 0.125, 'Company': 'Aircastle LTD', 'Gap': -0.0016, 'Relative Volume': 0.39, 'Volatility (Month)': 0.0193, 'Market Cap': 1330.3, 'Volume': 200382, 'Short Ratio': 3.78, 'Performance (Half Year)': 0.2295, 'Relative Strength Index (14)': 58.67, 'Insider Ownership': 0.008, '20-Day Simple Moving Average': 0.0054, 'Performance (Month)': 0.0849, 'P/Free Cash Flow': 3.39, 'Institutional Transactions': -0.0268, 'Performance (Year)': 0.7493, 'LT Debt/Equity': 2.08, 'Average Volume': 559.42, 'EPS growth this year': -0.72, '50-Day Simple Moving Average': 0.0545} 
    
    {'_id': ObjectId('52853801bb1177ca391c1a97'), 'Ticker': 'BK', 'Profit Margin': 0.63, 'Institutional Ownership': 0.826, 'EPS growth past 5 years': -0.03, 'Total Debt/Equity': 0.53, 'Return on Assets': 0.006, 'Sector': 'Financial', 'P/S': 11.32, 'Change from Open': -0.0015, 'Performance (YTD)': 0.3095, 'Performance (Week)': 0.0195, 'Insider Transactions': -0.1546, 'P/B': 1.07, 'EPS growth quarter over quarter': 0.344, 'Payout Ratio': 0.304, 'Performance (Quarter)': 0.0898, 'Forward P/E': 13.19, 'P/E': 18.03, '200-Day Simple Moving Average': 0.127, 'Shares Outstanding': 1148.72, 'Earnings Date': datetime.datetime(2013, 10, 16, 12, 30), '52-Week High': -0.0069, 'P/Cash': 0.22, 'Change': 0.003, 'Analyst Recom': 2.7, 'Volatility (Week)': 0.0216, 'Country': 'USA', 'Return on Equity': 0.06, '50-Day Low': 0.1255, 'Price': 33.1, '50-Day High': -0.0069, 'Return on Investment': 0.042, 'Shares Float': 1146.23, 'Dividend Yield': 0.0182, 'EPS growth next 5 years': 0.066, 'Industry': 'Asset Management', 'Beta': 1.16, 'Sales growth quarter over quarter': -0.025, 'EPS (ttm)': 1.83, 'PEG': 2.73, 'Float Short': 0.0125, '52-Week Low': 0.4512, 'Average True Range': 0.54, 'EPS growth next year': 0.096, 'Sales growth past 5 years': -0.092, 'Company': 'The Bank of New York Mellon Corporation', 'Gap': 0.0045, 'Relative Volume': 0.61, 'Volatility (Month)': 0.0155, 'Market Cap': 37907.89, 'Volume': 2578576, 'Short Ratio': 3.1, 'Performance (Half Year)': 0.1156, 'Relative Strength Index (14)': 63.27, 'Insider Ownership': 0.001, '20-Day Simple Moving Average': 0.032, 'Performance (Month)': 0.0749, 'Institutional Transactions': 0.0015, 'Performance (Year)': 0.4019, 'LT Debt/Equity': 0.53, 'Average Volume': 4611.68, 'EPS growth this year': 0, '50-Day Simple Moving Average': 0.0626} 
    
    {'_id': ObjectId('52853801bb1177ca391c1abd'), 'Ticker': 'BLX', 'Profit Margin': 0.588, 'Institutional Ownership': 0.281, 'EPS growth past 5 years': 0.045, 'Total Debt/Equity': 3.73, 'Return on Assets': 0.017, 'Sector': 'Financial', 'P/S': 5.22, 'Change from Open': 0.0103, 'Performance (YTD)': 0.2812, 'Performance (Week)': -0.0131, 'P/B': 1.19, 'EPS growth quarter over quarter': -0.506, 'Payout Ratio': 0.372, 'Performance (Quarter)': 0.0597, 'Forward P/E': 9.32, 'P/E': 13.01, '200-Day Simple Moving Average': 0.1134, 'Shares Outstanding': 38.22, 'Earnings Date': datetime.datetime(2013, 10, 16, 12, 30), '52-Week High': -0.0161, 'P/Cash': 1.71, 'Change': 0.0095, 'Analyst Recom': 1.7, 'Volatility (Week)': 0.023, 'Country': 'Panama', 'Return on Equity': 0.137, '50-Day Low': 0.1075, 'Price': 26.54, '50-Day High': -0.0161, 'Return on Investment': 0.027, 'Shares Float': 29.25, 'Dividend Yield': 0.0456, 'EPS growth next 5 years': 0.0698, 'Industry': 'Foreign Money Center Banks', 'Beta': 1.19, 'Sales growth quarter over quarter': 0, 'Operating Margin': 0.809, 'EPS (ttm)': 2.02, 'PEG': 1.86, 'Float Short': 0.0296, '52-Week Low': 0.366, 'Average True Range': 0.49, 'EPS growth next year': 0.2192, 'Sales growth past 5 years': -0.062, 'Company': 'Banco Latinoamericano de Comercio Exterior, S.A', 'Gap': -0.0008, 'Relative Volume': 1.05, 'Volatility (Month)': 0.0205, 'Market Cap': 1004.75, 'Volume': 102478, 'Short Ratio': 8.07, 'Performance (Half Year)': 0.1597, 'Relative Strength Index (14)': 60.34, 'Insider Ownership': 0.0706, '20-Day Simple Moving Average': 0.0098, 'Performance (Month)': 0.0554, 'P/Free Cash Flow': 56.77, 'Institutional Transactions': 0.0149, 'Performance (Year)': 0.2983, 'LT Debt/Equity': 1.91, 'Average Volume': 107.45, 'EPS growth this year': 0.098, '50-Day Simple Moving Average': 0.0498} 
    
    {'_id': ObjectId('52853801bb1177ca391c1af0'), 'Ticker': 'BPO', 'Profit Margin': 0.503, 'Institutional Ownership': 0.958, 'EPS growth past 5 years': 0.354, 'Total Debt/Equity': 1.15, 'Current Ratio': 1, 'Return on Assets': 0.043, 'Sector': 'Financial', 'P/S': 4.04, 'Change from Open': 0.001, 'Performance (YTD)': 0.1519, 'Performance (Week)': -0.0052, 'Quick Ratio': 1, 'P/B': 0.9, 'EPS growth quarter over quarter': -0.415, 'Payout Ratio': 0.235, 'Performance (Quarter)': 0.1825, 'Forward P/E': 18.74, 'P/E': 8.65, '200-Day Simple Moving Average': 0.1124, 'Shares Outstanding': 505, 'Earnings Date': datetime.datetime(2011, 2, 11, 13, 30), '52-Week High': -0.022, 'P/Cash': 22.13, 'Change': 0.0021, 'Analyst Recom': 3.1, 'Volatility (Week)': 0.0127, 'Country': 'USA', 'Return on Equity': 0.115, '50-Day Low': 0.1976, 'Price': 19.15, '50-Day High': -0.022, 'Return on Investment': 0.015, 'Shares Float': 504.86, 'Dividend Yield': 0.0293, 'EPS growth next 5 years': 0.0735, 'Industry': 'Property Management', 'Beta': 1.64, 'Sales growth quarter over quarter': 0.01, 'Operating Margin': 0.552, 'EPS (ttm)': 2.21, 'PEG': 1.18, 'Float Short': 0.0062, '52-Week Low': 0.2728, 'Average True Range': 0.23, 'EPS growth next year': -0.105, 'Sales growth past 5 years': -0.043, 'Company': 'Brookfield Properties Corporation', 'Gap': 0.001, 'Relative Volume': 0.17, 'Volatility (Month)': 0.0112, 'Market Cap': 9650.55, 'Volume': 249482, 'Gross Margin': 0.621, 'Short Ratio': 1.9, 'Performance (Half Year)': 0.0269, 'Relative Strength Index (14)': 62.08, 'Insider Ownership': 0.4972, '20-Day Simple Moving Average': 0.012, 'Performance (Month)': 0.0154, 'Institutional Transactions': -0.004, 'Performance (Year)': 0.2482, 'LT Debt/Equity': 1.15, 'Average Volume': 1650.73, 'EPS growth this year': -0.212, '50-Day Simple Moving Average': 0.0538} 
    
    

2) Liste as ações com perdas (limite a 10 novamente)



```python
stock_list = stocks.find({
    "Profit Margin" : {"$lt": 0}
}).limit(10)

for s in stock_list:
    print(s,"\n")
```

    {'_id': ObjectId('52853800bb1177ca391c1806'), 'Ticker': 'AAOI', 'Profit Margin': -0.023, 'Institutional Ownership': 0.114, 'EPS growth past 5 years': 0, 'Current Ratio': 1.5, 'Return on Assets': -0.048, 'Sector': 'Technology', 'P/S': 2.3, 'Change from Open': -0.0215, 'Performance (YTD)': 0.2671, 'Performance (Week)': -0.0381, 'Quick Ratio': 0.9, 'EPS growth quarter over quarter': -1, 'Forward P/E': 12.77, '200-Day Simple Moving Average': 0.0654, 'Shares Outstanding': 12.6, '52-Week High': -0.0904, 'P/Cash': 16.23, 'Change': -0.0269, 'Analyst Recom': 1.8, 'Volatility (Week)': 0.0377, 'Country': 'USA', 'Return on Equity': 0.043, '50-Day Low': 0.3539, 'Price': 12.28, '50-Day High': -0.0904, 'Return on Investment': -0.004, 'Shares Float': 11.46, 'Industry': 'Semiconductor - Integrated Circuits', 'Sales growth quarter over quarter': 0.256, 'Operating Margin': -0.007, 'EPS (ttm)': -0.13, 'Float Short': 0.0011, '52-Week Low': 0.3539, 'Average True Range': 0.63, 'EPS growth next year': 38.52, 'Company': 'Applied Optoelectronics, Inc.', 'Gap': -0.0055, 'Relative Volume': 0.12, 'Volatility (Month)': 0.0608, 'Market Cap': 159.06, 'Volume': 12203, 'Gross Margin': 0.292, 'Short Ratio': 0.12, 'Insider Ownership': 0.021, '20-Day Simple Moving Average': -0.0251, 'Performance (Month)': 0.2397, 'Average Volume': 110.95, 'EPS growth this year': 0.833, '50-Day Simple Moving Average': 0.0654} 
    
    {'_id': ObjectId('52853800bb1177ca391c180c'), 'Ticker': 'AAV', 'Profit Margin': -0.232, 'Institutional Ownership': 0.58, 'EPS growth past 5 years': -0.265, 'Total Debt/Equity': 0.32, 'Current Ratio': 0.8, 'Return on Assets': -0.032, 'Sector': 'Basic Materials', 'P/S': 2.64, 'Change from Open': 0.0286, 'Performance (YTD)': 0.1914, 'Performance (Week)': 0.0158, 'Quick Ratio': 0.8, 'P/B': 0.63, 'EPS growth quarter over quarter': 1.556, 'Performance (Quarter)': 0.0349, '200-Day Simple Moving Average': 0.0569, 'Shares Outstanding': 168.38, 'Earnings Date': datetime.datetime(2011, 3, 16, 4, 0), '52-Week High': -0.1242, 'Change': 0.0233, 'Analyst Recom': 2.7, 'Volatility (Week)': 0.0381, 'Country': 'Canada', 'Return on Equity': -0.055, '50-Day Low': 0.1127, 'Price': 3.95, '50-Day High': -0.0436, 'Return on Investment': -0.068, 'Shares Float': 167.07, 'Industry': 'Oil & Gas Drilling & Exploration', 'Beta': 2.05, 'Sales growth quarter over quarter': 0.399, 'Operating Margin': 0.102, 'EPS (ttm)': -0.34, 'Float Short': 0.0008, '52-Week Low': 0.4158, 'Average True Range': 0.12, 'EPS growth next year': -0.667, 'Sales growth past 5 years': -0.121, 'Company': 'Advantage Oil & Gas Ltd.', 'Gap': -0.0052, 'Relative Volume': 0.85, 'Volatility (Month)': 0.0303, 'Market Cap': 649.96, 'Volume': 116750, 'Gross Margin': 0.682, 'Short Ratio': 0.89, 'Performance (Half Year)': 0.0078, 'Relative Strength Index (14)': 52.62, 'Insider Ownership': 0.0025, '20-Day Simple Moving Average': -0.0001, 'Performance (Month)': 0.0158, 'Institutional Transactions': 0.0402, 'Performance (Year)': 0.1386, 'LT Debt/Equity': 0.32, 'Average Volume': 149.81, 'EPS growth this year': 0.42, '50-Day Simple Moving Average': 0.023} 
    
    {'_id': ObjectId('52853800bb1177ca391c1815'), 'Ticker': 'ABCD', 'Profit Margin': -0.645, 'Institutional Ownership': 0.186, 'EPS growth past 5 years': -0.195, 'Current Ratio': 1.4, 'Return on Assets': -0.416, 'Sector': 'Services', 'P/S': 0.41, 'Change from Open': 0, 'Performance (YTD)': 0.2072, 'Performance (Week)': 0.0229, 'Quick Ratio': 1.2, 'Insider Transactions': -0.0267, 'EPS growth quarter over quarter': 1.022, 'Performance (Quarter)': -0.0496, '200-Day Simple Moving Average': 0.0446, 'Shares Outstanding': 47.36, 'Earnings Date': datetime.datetime(2013, 11, 7, 21, 30), '52-Week High': -0.2757, 'P/Cash': 1.37, 'Change': 0, 'Analyst Recom': 2, 'Volatility (Week)': 0.0737, 'Country': 'USA', 'Return on Equity': 3.596, '50-Day Low': 0.072, 'Price': 1.34, '50-Day High': -0.2299, 'Return on Investment': -0.876, 'Shares Float': 15.11, 'Industry': 'Education & Training Services', 'Beta': 1.7, 'Sales growth quarter over quarter': 0.059, 'Operating Margin': 0.048, 'EPS (ttm)': -2.06, 'Float Short': 0.0007, '52-Week Low': 0.5952, 'Average True Range': 0.09, 'Sales growth past 5 years': 0.084, 'Company': 'Cambium Learning Group, Inc.', 'Gap': 0, 'Relative Volume': 0.04, 'Volatility (Month)': 0.0584, 'Market Cap': 63.46, 'Volume': 1600, 'Gross Margin': 0.552, 'Short Ratio': 0.21, 'Performance (Half Year)': 0.1356, 'Relative Strength Index (14)': 48.07, 'Insider Ownership': 0.003, '20-Day Simple Moving Average': 0.0037, 'Performance (Month)': -0.0074, 'P/Free Cash Flow': 2.47, 'Institutional Transactions': -0.095, 'Performance (Year)': 0.6543, 'Average Volume': 48.58, 'EPS growth this year': -1.533, '50-Day Simple Moving Average': -0.064} 
    
    {'_id': ObjectId('52853800bb1177ca391c1817'), 'Ticker': 'ABFS', 'Profit Margin': -0.005, 'Institutional Ownership': 0.921, 'EPS growth past 5 years': -0.164, 'Total Debt/Equity': 0.31, 'Current Ratio': 1.3, 'Return on Assets': -0.01, 'Sector': 'Services', 'P/S': 0.37, 'Change from Open': -0.006, 'Performance (YTD)': 2.3474, 'Performance (Week)': 0.1949, 'Quick Ratio': 1.3, 'Insider Transactions': 0.1293, 'P/B': 1.69, 'EPS growth quarter over quarter': -0.591, 'Performance (Quarter)': 0.3813, 'Forward P/E': 18.66, '200-Day Simple Moving Average': 0.6449, 'Shares Outstanding': 25.69, 'Earnings Date': datetime.datetime(2013, 11, 11, 13, 30), '52-Week High': -0.0166, 'P/Cash': 6.87, 'Change': -0.0082, 'Analyst Recom': 2.8, 'Volatility (Week)': 0.0625, 'Country': 'USA', 'Return on Equity': -0.022, '50-Day Low': 0.474, 'Price': 31.44, '50-Day High': -0.0166, 'Return on Investment': -0.008, 'Shares Float': 24.3, 'Dividend Yield': 0.0038, 'EPS growth next 5 years': 0.1, 'Industry': 'Trucking', 'Beta': 1.91, 'Sales growth quarter over quarter': 0.13, 'Operating Margin': -0.006, 'EPS (ttm)': -0.4, 'Float Short': 0.1176, '52-Week Low': 3.9271, 'Average True Range': 1.58, 'EPS growth next year': 7.0142, 'Sales growth past 5 years': 0.024, 'Company': 'Arkansas Best Corporation', 'Gap': -0.0022, 'Relative Volume': 0.73, 'Volatility (Month)': 0.0537, 'Market Cap': 814.5, 'Volume': 351906, 'Gross Margin': 0.212, 'Short Ratio': 5.44, 'Performance (Half Year)': 0.8592, 'Relative Strength Index (14)': 67.77, 'Insider Ownership': 0.034, '20-Day Simple Moving Average': 0.1304, 'Performance (Month)': 0.3319, 'P/Free Cash Flow': 13.67, 'Institutional Transactions': 0.0328, 'Performance (Year)': 3.4336, 'LT Debt/Equity': 0.2, 'Average Volume': 525.42, 'EPS growth this year': -2.348, '50-Day Simple Moving Average': 0.1974} 
    
    {'_id': ObjectId('52853800bb1177ca391c181b'), 'Ticker': 'ABMC', 'Profit Margin': -0.0966, 'Institutional Ownership': 0.12, 'EPS growth past 5 years': 0, 'Total Debt/Equity': 0.63, 'Current Ratio': 1.74, 'Return on Assets': -0.1194, 'Sector': 'Healthcare', 'P/S': 0.34, 'Change from Open': 0, 'Performance (YTD)': 0.3077, 'Performance (Week)': 0.1333, 'Quick Ratio': 0.57, 'P/B': 1, 'EPS growth quarter over quarter': -2.4252, 'Performance (Quarter)': 0, '200-Day Simple Moving Average': 0.0413, 'Shares Outstanding': 21.74, 'Earnings Date': datetime.datetime(2013, 11, 11, 5, 0), '52-Week High': -0.3929, 'P/Cash': 6.26, 'Change': 0, 'Volatility (Week)': 0.0695, 'Country': 'USA', 'Return on Equity': -0.2455, '50-Day Low': 1.4286, 'Price': 0.17, '50-Day High': -0.0556, 'Return on Investment': -0.1961, 'Shares Float': 18.7, 'Industry': 'Diagnostic Substances', 'Beta': 1.71, 'Sales growth quarter over quarter': -0.1896, 'Operating Margin': -0.0734, 'EPS (ttm)': -0.05, 'Float Short': 0.0003, '52-Week Low': 1.4286, 'Average True Range': 0.02, 'Sales growth past 5 years': 0.0028, 'Company': 'American Bio Medica Corp.', 'Gap': 0, 'Relative Volume': 0.04, 'Volatility (Month)': 0.0517, 'Market Cap': 3.7, 'Volume': 0, 'Gross Margin': 0.3916, 'Short Ratio': 0.43, 'Performance (Half Year)': 0.0625, 'Relative Strength Index (14)': 56.93, 'Insider Ownership': 0.14, '20-Day Simple Moving Average': 0.1039, 'Performance (Month)': 0.2143, 'Institutional Transactions': -0.1183, 'Performance (Year)': -0.0556, 'LT Debt/Equity': 0.2, 'Average Volume': 13.73, 'EPS growth this year': 0.1416, '50-Day Simple Moving Average': 0.1502} 
    
    {'_id': ObjectId('52853800bb1177ca391c1821'), 'Ticker': 'ABX', 'Profit Margin': -0.769, 'Institutional Ownership': 0.739, 'EPS growth past 5 years': -0.206, 'Total Debt/Equity': 1.13, 'Current Ratio': 1.8, 'Return on Assets': -0.241, 'Sector': 'Basic Materials', 'P/S': 1.32, 'Change from Open': -0.0019, 'Performance (YTD)': -0.4728, 'Performance (Week)': -0.0131, 'Quick Ratio': 1, 'P/B': 1.33, 'EPS growth quarter over quarter': -0.727, 'Performance (Quarter)': -0.084, 'Forward P/E': 8.19, '200-Day Simple Moving Average': -0.1368, 'Shares Outstanding': 1001, 'Earnings Date': datetime.datetime(2011, 2, 17, 13, 30), '52-Week High': -0.4877, 'P/Cash': 7.94, 'Change': 0.0014, 'Analyst Recom': 2.6, 'Volatility (Week)': 0.0202, 'Country': 'Canada', 'Return on Equity': -0.592, '50-Day Low': 0.0581, 'Price': 18.13, '50-Day High': -0.121, 'Return on Investment': -0.017, 'Shares Float': 997.93, 'Dividend Yield': 0.011, 'EPS growth next 5 years': 0.02, 'Industry': 'Gold', 'Beta': 0.46, 'Sales growth quarter over quarter': -0.122, 'Operating Margin': 0.366, 'EPS (ttm)': -10.08, 'Float Short': 0.0118, '52-Week Low': 0.3525, 'Average True Range': 0.57, 'EPS growth next year': -0.16, 'Sales growth past 5 years': 0.193, 'Company': 'Barrick Gold Corporation', 'Gap': 0.0033, 'Relative Volume': 1.09, 'Volatility (Month)': 0.0277, 'Market Cap': 18118.1, 'Volume': 17478164, 'Gross Margin': 0.444, 'Short Ratio': 0.67, 'Performance (Half Year)': -0.0479, 'Relative Strength Index (14)': 41.96, '20-Day Simple Moving Average': -0.0436, 'Performance (Month)': 0.018, 'Institutional Transactions': 0.0315, 'Performance (Year)': -0.474, 'LT Debt/Equity': 1.07, 'Average Volume': 17602.98, 'EPS growth this year': -1.147, '50-Day Simple Moving Average': -0.0239} 
    
    {'_id': ObjectId('52853800bb1177ca391c1826'), 'Ticker': 'ACCL', 'Profit Margin': -0.014, 'Institutional Ownership': 0.911, 'EPS growth past 5 years': -0.421, 'Total Debt/Equity': 0, 'Current Ratio': 1.4, 'Return on Assets': -0.006, 'Sector': 'Technology', 'P/S': 3.13, 'Change from Open': 0.0011, 'Performance (YTD)': 0.0331, 'Performance (Week)': 0.0108, 'Quick Ratio': 1.4, 'Insider Transactions': -0.1768, 'P/B': 2.1, 'Performance (Quarter)': 0.0331, 'Forward P/E': 24.35, '200-Day Simple Moving Average': 0.0112, 'Shares Outstanding': 55.66, 'Earnings Date': datetime.datetime(2013, 10, 30, 20, 30), '52-Week High': -0.071, 'P/Cash': 4.14, 'Change': -0.0064, 'Analyst Recom': 2.3, 'Volatility (Week)': 0.0189, 'Country': 'USA', 'Return on Equity': -0.01, '50-Day Low': 0.0322, 'Price': 9.29, '50-Day High': -0.071, 'Return on Investment': -0.086, 'Shares Float': 55.4, 'EPS growth next 5 years': 0.2, 'Industry': 'Application Software', 'Beta': 0.84, 'Sales growth quarter over quarter': 0.01, 'Operating Margin': -0.091, 'EPS (ttm)': -0.05, 'Float Short': 0.0179, '52-Week Low': 0.1987, 'Average True Range': 0.21, 'EPS growth next year': 0.1294, 'Sales growth past 5 years': 0.153, 'Company': 'Accelrys Inc.', 'Gap': -0.0075, 'Relative Volume': 0.31, 'Volatility (Month)': 0.0236, 'Market Cap': 520.42, 'Volume': 33912, 'Gross Margin': 0.679, 'Short Ratio': 8.32, 'Performance (Half Year)': 0.0872, 'Relative Strength Index (14)': 45.52, 'Insider Ownership': 0.0092, '20-Day Simple Moving Average': -0.018, 'Performance (Month)': -0.0032, 'Institutional Transactions': 0.0133, 'Performance (Year)': 0.0747, 'LT Debt/Equity': 0, 'Average Volume': 118.95, 'EPS growth this year': -7.333, '50-Day Simple Moving Average': -0.0226} 
    
    {'_id': ObjectId('52853800bb1177ca391c182b'), 'Ticker': 'ACFC', 'Profit Margin': -0.18, 'Institutional Ownership': 0.079, 'EPS growth past 5 years': -0.524, 'Total Debt/Equity': 0, 'Return on Assets': -0.007, 'Sector': 'Financial', 'P/S': 0.27, 'Change from Open': 0, 'Performance (YTD)': 0.6667, 'Performance (Week)': -0.1184, 'P/B': 0.27, 'EPS growth quarter over quarter': 0.483, 'Performance (Quarter)': -0.1321, '200-Day Simple Moving Average': -0.2118, 'Shares Outstanding': 2.5, 'Earnings Date': datetime.datetime(2013, 11, 4, 5, 0), '52-Week High': -0.4956, 'P/Cash': 0.1, 'Change': 0.0358, 'Analyst Recom': 3, 'Volatility (Week)': 0.0508, 'Country': 'USA', 'Return on Equity': -0.147, '50-Day Low': 0.081, 'Price': 3.47, '50-Day High': -0.2078, 'Return on Investment': 0.161, 'Shares Float': 1.72, 'Industry': 'Regional - Southeast Banks', 'Beta': 0.83, 'Sales growth quarter over quarter': -0.14, 'Operating Margin': -0.18, 'EPS (ttm)': -2.22, 'Float Short': 0.0085, '52-Week Low': 1.3767, 'Average True Range': 0.12, 'Sales growth past 5 years': -0.096, 'Company': 'Atlantic Coast Financial Corporation', 'Gap': 0.0358, 'Relative Volume': 0, 'Volatility (Month)': 0.0228, 'Market Cap': 8.39, 'Volume': 0, 'Short Ratio': 6.07, 'Performance (Half Year)': -0.3667, 'Relative Strength Index (14)': 40.71, 'Insider Ownership': 0.001, '20-Day Simple Moving Average': -0.0742, 'Performance (Month)': -0.1138, 'Institutional Transactions': -4.3825, 'Performance (Year)': 0.7539, 'LT Debt/Equity': 0, 'Average Volume': 2.41, 'EPS growth this year': 0.354, '50-Day Simple Moving Average': -0.0993} 
    
    {'_id': ObjectId('52853800bb1177ca391c182f'), 'Ticker': 'ACH', 'Profit Margin': -0.051, 'Institutional Ownership': 0.02, 'EPS growth past 5 years': -0.227, 'Total Debt/Equity': 2.84, 'Current Ratio': 0.7, 'Return on Assets': -0.039, 'Sector': 'Basic Materials', 'P/S': 0.19, 'Change from Open': -0.0032, 'Performance (YTD)': -0.2645, 'Performance (Week)': -0.0437, 'Quick Ratio': 0.7, 'P/B': 0.67, 'EPS growth quarter over quarter': 0.711, 'Performance (Quarter)': 0.0057, '200-Day Simple Moving Average': -0.0544, 'Shares Outstanding': 540.98, 'Earnings Date': datetime.datetime(2011, 3, 2, 5, 0), '52-Week High': -0.3369, 'P/Cash': 2.77, 'Change': 0.0059, 'Analyst Recom': 5, 'Volatility (Week)': 0.015, 'Country': 'China', 'Return on Equity': -0.172, '50-Day Low': 0.0176, 'Price': 8.81, '50-Day High': -0.1117, 'Return on Investment': -0.029, 'Shares Float': 156.18, 'Industry': 'Aluminum', 'Beta': 1.9, 'Sales growth quarter over quarter': 0.065, 'Operating Margin': -0.021, 'EPS (ttm)': -1.76, 'Float Short': 0.02, '52-Week Low': 0.2154, 'Average True Range': 0.2, 'EPS growth next year': 0.487, 'Sales growth past 5 years': 0.119, 'Company': 'Aluminum Corporation Of China Limited', 'Gap': 0.0091, 'Relative Volume': 1.05, 'Volatility (Month)': 0.0183, 'Market Cap': 4738.98, 'Volume': 78010, 'Gross Margin': 0.005, 'Short Ratio': 38.23, 'Performance (Half Year)': -0.124, 'Relative Strength Index (14)': 38.92, '20-Day Simple Moving Average': -0.0477, 'Performance (Month)': -0.0405, 'Institutional Transactions': -0.0063, 'Performance (Year)': -0.1577, 'LT Debt/Equity': 1.19, 'Average Volume': 81.57, 'EPS growth this year': 0.839, '50-Day Simple Moving Average': -0.0421} 
    
    {'_id': ObjectId('52853800bb1177ca391c1832'), 'Ticker': 'ACI', 'Profit Margin': -0.173, 'Institutional Ownership': 0.662, 'EPS growth past 5 years': -0.361, 'Total Debt/Equity': 1.97, 'Current Ratio': 3.5, 'Return on Assets': -0.058, 'Sector': 'Basic Materials', 'P/S': 0.28, 'Change from Open': -0.0372, 'Performance (YTD)': -0.4019, 'Performance (Week)': -0.0183, 'Quick Ratio': 3, 'Insider Transactions': 0.0178, 'P/B': 0.35, 'EPS growth quarter over quarter': -5.455, 'Performance (Quarter)': -0.0549, '200-Day Simple Moving Average': -0.1177, 'Shares Outstanding': 212.11, 'Earnings Date': datetime.datetime(2013, 10, 29, 12, 30), '52-Week High': -0.4702, 'P/Cash': 0.66, 'Change': -0.0372, 'Analyst Recom': 2.8, 'Volatility (Week)': 0.0516, 'Country': 'USA', 'Return on Equity': -0.207, '50-Day Low': 0.104, 'Price': 4.14, '50-Day High': -0.2114, 'Return on Investment': -0.047, 'Shares Float': 209.56, 'Dividend Yield': 0.0279, 'EPS growth next 5 years': 0.05, 'Industry': 'Industrial Metals & Minerals', 'Beta': 1.61, 'Sales growth quarter over quarter': -0.272, 'Operating Margin': -0.04, 'EPS (ttm)': -3.16, 'Float Short': 0.1772, '52-Week Low': 0.1997, 'Average True Range': 0.23, 'EPS growth next year': 0.143, 'Sales growth past 5 years': 0.115, 'Company': 'Arch Coal Inc.', 'Gap': 0, 'Relative Volume': 0.66, 'Volatility (Month)': 0.0546, 'Market Cap': 912.08, 'Volume': 5417562, 'Gross Margin': 0.141, 'Short Ratio': 4.12, 'Performance (Half Year)': -0.1224, 'Relative Strength Index (14)': 43.64, 'Insider Ownership': 0.0054, '20-Day Simple Moving Average': -0.0171, 'Performance (Month)': 0.0437, 'Institutional Transactions': 0.0024, 'Performance (Year)': -0.3741, 'LT Debt/Equity': 1.97, 'Average Volume': 9000.5, 'EPS growth this year': -5.378, '50-Day Simple Moving Average': -0.0482} 
    
    

3) Liste as 10 ações mais rentáveis



```python
stocks.find({}).sort({"Profit Margin" : -1}).limit(10)
```

4) Qual foi o setor mais rentável?



```python
sector = stocks.aggregate([
    {"$group": { "_id": "$Sector" , "total": {"$sum": "$Profit Margin" }}},
    {"$sort": { "total": -1 }}
])

for s in sector:
    print(s, "\n")
```

    {'_id': 'Financial', 'total': 162.5356} 
    
    {'_id': 'Services', 'total': 20.5515} 
    
    {'_id': 'Consumer Goods', 'total': 13.23} 
    
    {'_id': 'Industrial Goods', 'total': 11.0327} 
    
    {'_id': 'Utilities', 'total': 7.423} 
    
    {'_id': 'Conglomerates', 'total': 0.3835} 
    
    {'_id': 'Basic Materials', 'total': -9.190900000000001} 
    
    {'_id': 'Technology', 'total': -18.8968} 
    
    {'_id': 'Healthcare', 'total': -316.68649999999997} 
    
    

5) Ordene as ações pelo profit e usando um cursor, liste as ações.



```python
stock_list = stocks.find({
    "Profit Margin" : {"$lt": 0}
}).limit(10)

for s in stock_list:
    print(s, "\n")

```

    {'_id': ObjectId('52853800bb1177ca391c1806'), 'Ticker': 'AAOI', 'Profit Margin': -0.023, 'Institutional Ownership': 0.114, 'EPS growth past 5 years': 0, 'Current Ratio': 1.5, 'Return on Assets': -0.048, 'Sector': 'Technology', 'P/S': 2.3, 'Change from Open': -0.0215, 'Performance (YTD)': 0.2671, 'Performance (Week)': -0.0381, 'Quick Ratio': 0.9, 'EPS growth quarter over quarter': -1, 'Forward P/E': 12.77, '200-Day Simple Moving Average': 0.0654, 'Shares Outstanding': 12.6, '52-Week High': -0.0904, 'P/Cash': 16.23, 'Change': -0.0269, 'Analyst Recom': 1.8, 'Volatility (Week)': 0.0377, 'Country': 'USA', 'Return on Equity': 0.043, '50-Day Low': 0.3539, 'Price': 12.28, '50-Day High': -0.0904, 'Return on Investment': -0.004, 'Shares Float': 11.46, 'Industry': 'Semiconductor - Integrated Circuits', 'Sales growth quarter over quarter': 0.256, 'Operating Margin': -0.007, 'EPS (ttm)': -0.13, 'Float Short': 0.0011, '52-Week Low': 0.3539, 'Average True Range': 0.63, 'EPS growth next year': 38.52, 'Company': 'Applied Optoelectronics, Inc.', 'Gap': -0.0055, 'Relative Volume': 0.12, 'Volatility (Month)': 0.0608, 'Market Cap': 159.06, 'Volume': 12203, 'Gross Margin': 0.292, 'Short Ratio': 0.12, 'Insider Ownership': 0.021, '20-Day Simple Moving Average': -0.0251, 'Performance (Month)': 0.2397, 'Average Volume': 110.95, 'EPS growth this year': 0.833, '50-Day Simple Moving Average': 0.0654} 
    
    {'_id': ObjectId('52853800bb1177ca391c180c'), 'Ticker': 'AAV', 'Profit Margin': -0.232, 'Institutional Ownership': 0.58, 'EPS growth past 5 years': -0.265, 'Total Debt/Equity': 0.32, 'Current Ratio': 0.8, 'Return on Assets': -0.032, 'Sector': 'Basic Materials', 'P/S': 2.64, 'Change from Open': 0.0286, 'Performance (YTD)': 0.1914, 'Performance (Week)': 0.0158, 'Quick Ratio': 0.8, 'P/B': 0.63, 'EPS growth quarter over quarter': 1.556, 'Performance (Quarter)': 0.0349, '200-Day Simple Moving Average': 0.0569, 'Shares Outstanding': 168.38, 'Earnings Date': datetime.datetime(2011, 3, 16, 4, 0), '52-Week High': -0.1242, 'Change': 0.0233, 'Analyst Recom': 2.7, 'Volatility (Week)': 0.0381, 'Country': 'Canada', 'Return on Equity': -0.055, '50-Day Low': 0.1127, 'Price': 3.95, '50-Day High': -0.0436, 'Return on Investment': -0.068, 'Shares Float': 167.07, 'Industry': 'Oil & Gas Drilling & Exploration', 'Beta': 2.05, 'Sales growth quarter over quarter': 0.399, 'Operating Margin': 0.102, 'EPS (ttm)': -0.34, 'Float Short': 0.0008, '52-Week Low': 0.4158, 'Average True Range': 0.12, 'EPS growth next year': -0.667, 'Sales growth past 5 years': -0.121, 'Company': 'Advantage Oil & Gas Ltd.', 'Gap': -0.0052, 'Relative Volume': 0.85, 'Volatility (Month)': 0.0303, 'Market Cap': 649.96, 'Volume': 116750, 'Gross Margin': 0.682, 'Short Ratio': 0.89, 'Performance (Half Year)': 0.0078, 'Relative Strength Index (14)': 52.62, 'Insider Ownership': 0.0025, '20-Day Simple Moving Average': -0.0001, 'Performance (Month)': 0.0158, 'Institutional Transactions': 0.0402, 'Performance (Year)': 0.1386, 'LT Debt/Equity': 0.32, 'Average Volume': 149.81, 'EPS growth this year': 0.42, '50-Day Simple Moving Average': 0.023} 
    
    {'_id': ObjectId('52853800bb1177ca391c1815'), 'Ticker': 'ABCD', 'Profit Margin': -0.645, 'Institutional Ownership': 0.186, 'EPS growth past 5 years': -0.195, 'Current Ratio': 1.4, 'Return on Assets': -0.416, 'Sector': 'Services', 'P/S': 0.41, 'Change from Open': 0, 'Performance (YTD)': 0.2072, 'Performance (Week)': 0.0229, 'Quick Ratio': 1.2, 'Insider Transactions': -0.0267, 'EPS growth quarter over quarter': 1.022, 'Performance (Quarter)': -0.0496, '200-Day Simple Moving Average': 0.0446, 'Shares Outstanding': 47.36, 'Earnings Date': datetime.datetime(2013, 11, 7, 21, 30), '52-Week High': -0.2757, 'P/Cash': 1.37, 'Change': 0, 'Analyst Recom': 2, 'Volatility (Week)': 0.0737, 'Country': 'USA', 'Return on Equity': 3.596, '50-Day Low': 0.072, 'Price': 1.34, '50-Day High': -0.2299, 'Return on Investment': -0.876, 'Shares Float': 15.11, 'Industry': 'Education & Training Services', 'Beta': 1.7, 'Sales growth quarter over quarter': 0.059, 'Operating Margin': 0.048, 'EPS (ttm)': -2.06, 'Float Short': 0.0007, '52-Week Low': 0.5952, 'Average True Range': 0.09, 'Sales growth past 5 years': 0.084, 'Company': 'Cambium Learning Group, Inc.', 'Gap': 0, 'Relative Volume': 0.04, 'Volatility (Month)': 0.0584, 'Market Cap': 63.46, 'Volume': 1600, 'Gross Margin': 0.552, 'Short Ratio': 0.21, 'Performance (Half Year)': 0.1356, 'Relative Strength Index (14)': 48.07, 'Insider Ownership': 0.003, '20-Day Simple Moving Average': 0.0037, 'Performance (Month)': -0.0074, 'P/Free Cash Flow': 2.47, 'Institutional Transactions': -0.095, 'Performance (Year)': 0.6543, 'Average Volume': 48.58, 'EPS growth this year': -1.533, '50-Day Simple Moving Average': -0.064} 
    
    {'_id': ObjectId('52853800bb1177ca391c1817'), 'Ticker': 'ABFS', 'Profit Margin': -0.005, 'Institutional Ownership': 0.921, 'EPS growth past 5 years': -0.164, 'Total Debt/Equity': 0.31, 'Current Ratio': 1.3, 'Return on Assets': -0.01, 'Sector': 'Services', 'P/S': 0.37, 'Change from Open': -0.006, 'Performance (YTD)': 2.3474, 'Performance (Week)': 0.1949, 'Quick Ratio': 1.3, 'Insider Transactions': 0.1293, 'P/B': 1.69, 'EPS growth quarter over quarter': -0.591, 'Performance (Quarter)': 0.3813, 'Forward P/E': 18.66, '200-Day Simple Moving Average': 0.6449, 'Shares Outstanding': 25.69, 'Earnings Date': datetime.datetime(2013, 11, 11, 13, 30), '52-Week High': -0.0166, 'P/Cash': 6.87, 'Change': -0.0082, 'Analyst Recom': 2.8, 'Volatility (Week)': 0.0625, 'Country': 'USA', 'Return on Equity': -0.022, '50-Day Low': 0.474, 'Price': 31.44, '50-Day High': -0.0166, 'Return on Investment': -0.008, 'Shares Float': 24.3, 'Dividend Yield': 0.0038, 'EPS growth next 5 years': 0.1, 'Industry': 'Trucking', 'Beta': 1.91, 'Sales growth quarter over quarter': 0.13, 'Operating Margin': -0.006, 'EPS (ttm)': -0.4, 'Float Short': 0.1176, '52-Week Low': 3.9271, 'Average True Range': 1.58, 'EPS growth next year': 7.0142, 'Sales growth past 5 years': 0.024, 'Company': 'Arkansas Best Corporation', 'Gap': -0.0022, 'Relative Volume': 0.73, 'Volatility (Month)': 0.0537, 'Market Cap': 814.5, 'Volume': 351906, 'Gross Margin': 0.212, 'Short Ratio': 5.44, 'Performance (Half Year)': 0.8592, 'Relative Strength Index (14)': 67.77, 'Insider Ownership': 0.034, '20-Day Simple Moving Average': 0.1304, 'Performance (Month)': 0.3319, 'P/Free Cash Flow': 13.67, 'Institutional Transactions': 0.0328, 'Performance (Year)': 3.4336, 'LT Debt/Equity': 0.2, 'Average Volume': 525.42, 'EPS growth this year': -2.348, '50-Day Simple Moving Average': 0.1974} 
    
    {'_id': ObjectId('52853800bb1177ca391c181b'), 'Ticker': 'ABMC', 'Profit Margin': -0.0966, 'Institutional Ownership': 0.12, 'EPS growth past 5 years': 0, 'Total Debt/Equity': 0.63, 'Current Ratio': 1.74, 'Return on Assets': -0.1194, 'Sector': 'Healthcare', 'P/S': 0.34, 'Change from Open': 0, 'Performance (YTD)': 0.3077, 'Performance (Week)': 0.1333, 'Quick Ratio': 0.57, 'P/B': 1, 'EPS growth quarter over quarter': -2.4252, 'Performance (Quarter)': 0, '200-Day Simple Moving Average': 0.0413, 'Shares Outstanding': 21.74, 'Earnings Date': datetime.datetime(2013, 11, 11, 5, 0), '52-Week High': -0.3929, 'P/Cash': 6.26, 'Change': 0, 'Volatility (Week)': 0.0695, 'Country': 'USA', 'Return on Equity': -0.2455, '50-Day Low': 1.4286, 'Price': 0.17, '50-Day High': -0.0556, 'Return on Investment': -0.1961, 'Shares Float': 18.7, 'Industry': 'Diagnostic Substances', 'Beta': 1.71, 'Sales growth quarter over quarter': -0.1896, 'Operating Margin': -0.0734, 'EPS (ttm)': -0.05, 'Float Short': 0.0003, '52-Week Low': 1.4286, 'Average True Range': 0.02, 'Sales growth past 5 years': 0.0028, 'Company': 'American Bio Medica Corp.', 'Gap': 0, 'Relative Volume': 0.04, 'Volatility (Month)': 0.0517, 'Market Cap': 3.7, 'Volume': 0, 'Gross Margin': 0.3916, 'Short Ratio': 0.43, 'Performance (Half Year)': 0.0625, 'Relative Strength Index (14)': 56.93, 'Insider Ownership': 0.14, '20-Day Simple Moving Average': 0.1039, 'Performance (Month)': 0.2143, 'Institutional Transactions': -0.1183, 'Performance (Year)': -0.0556, 'LT Debt/Equity': 0.2, 'Average Volume': 13.73, 'EPS growth this year': 0.1416, '50-Day Simple Moving Average': 0.1502} 
    
    {'_id': ObjectId('52853800bb1177ca391c1821'), 'Ticker': 'ABX', 'Profit Margin': -0.769, 'Institutional Ownership': 0.739, 'EPS growth past 5 years': -0.206, 'Total Debt/Equity': 1.13, 'Current Ratio': 1.8, 'Return on Assets': -0.241, 'Sector': 'Basic Materials', 'P/S': 1.32, 'Change from Open': -0.0019, 'Performance (YTD)': -0.4728, 'Performance (Week)': -0.0131, 'Quick Ratio': 1, 'P/B': 1.33, 'EPS growth quarter over quarter': -0.727, 'Performance (Quarter)': -0.084, 'Forward P/E': 8.19, '200-Day Simple Moving Average': -0.1368, 'Shares Outstanding': 1001, 'Earnings Date': datetime.datetime(2011, 2, 17, 13, 30), '52-Week High': -0.4877, 'P/Cash': 7.94, 'Change': 0.0014, 'Analyst Recom': 2.6, 'Volatility (Week)': 0.0202, 'Country': 'Canada', 'Return on Equity': -0.592, '50-Day Low': 0.0581, 'Price': 18.13, '50-Day High': -0.121, 'Return on Investment': -0.017, 'Shares Float': 997.93, 'Dividend Yield': 0.011, 'EPS growth next 5 years': 0.02, 'Industry': 'Gold', 'Beta': 0.46, 'Sales growth quarter over quarter': -0.122, 'Operating Margin': 0.366, 'EPS (ttm)': -10.08, 'Float Short': 0.0118, '52-Week Low': 0.3525, 'Average True Range': 0.57, 'EPS growth next year': -0.16, 'Sales growth past 5 years': 0.193, 'Company': 'Barrick Gold Corporation', 'Gap': 0.0033, 'Relative Volume': 1.09, 'Volatility (Month)': 0.0277, 'Market Cap': 18118.1, 'Volume': 17478164, 'Gross Margin': 0.444, 'Short Ratio': 0.67, 'Performance (Half Year)': -0.0479, 'Relative Strength Index (14)': 41.96, '20-Day Simple Moving Average': -0.0436, 'Performance (Month)': 0.018, 'Institutional Transactions': 0.0315, 'Performance (Year)': -0.474, 'LT Debt/Equity': 1.07, 'Average Volume': 17602.98, 'EPS growth this year': -1.147, '50-Day Simple Moving Average': -0.0239} 
    
    {'_id': ObjectId('52853800bb1177ca391c1826'), 'Ticker': 'ACCL', 'Profit Margin': -0.014, 'Institutional Ownership': 0.911, 'EPS growth past 5 years': -0.421, 'Total Debt/Equity': 0, 'Current Ratio': 1.4, 'Return on Assets': -0.006, 'Sector': 'Technology', 'P/S': 3.13, 'Change from Open': 0.0011, 'Performance (YTD)': 0.0331, 'Performance (Week)': 0.0108, 'Quick Ratio': 1.4, 'Insider Transactions': -0.1768, 'P/B': 2.1, 'Performance (Quarter)': 0.0331, 'Forward P/E': 24.35, '200-Day Simple Moving Average': 0.0112, 'Shares Outstanding': 55.66, 'Earnings Date': datetime.datetime(2013, 10, 30, 20, 30), '52-Week High': -0.071, 'P/Cash': 4.14, 'Change': -0.0064, 'Analyst Recom': 2.3, 'Volatility (Week)': 0.0189, 'Country': 'USA', 'Return on Equity': -0.01, '50-Day Low': 0.0322, 'Price': 9.29, '50-Day High': -0.071, 'Return on Investment': -0.086, 'Shares Float': 55.4, 'EPS growth next 5 years': 0.2, 'Industry': 'Application Software', 'Beta': 0.84, 'Sales growth quarter over quarter': 0.01, 'Operating Margin': -0.091, 'EPS (ttm)': -0.05, 'Float Short': 0.0179, '52-Week Low': 0.1987, 'Average True Range': 0.21, 'EPS growth next year': 0.1294, 'Sales growth past 5 years': 0.153, 'Company': 'Accelrys Inc.', 'Gap': -0.0075, 'Relative Volume': 0.31, 'Volatility (Month)': 0.0236, 'Market Cap': 520.42, 'Volume': 33912, 'Gross Margin': 0.679, 'Short Ratio': 8.32, 'Performance (Half Year)': 0.0872, 'Relative Strength Index (14)': 45.52, 'Insider Ownership': 0.0092, '20-Day Simple Moving Average': -0.018, 'Performance (Month)': -0.0032, 'Institutional Transactions': 0.0133, 'Performance (Year)': 0.0747, 'LT Debt/Equity': 0, 'Average Volume': 118.95, 'EPS growth this year': -7.333, '50-Day Simple Moving Average': -0.0226} 
    
    {'_id': ObjectId('52853800bb1177ca391c182b'), 'Ticker': 'ACFC', 'Profit Margin': -0.18, 'Institutional Ownership': 0.079, 'EPS growth past 5 years': -0.524, 'Total Debt/Equity': 0, 'Return on Assets': -0.007, 'Sector': 'Financial', 'P/S': 0.27, 'Change from Open': 0, 'Performance (YTD)': 0.6667, 'Performance (Week)': -0.1184, 'P/B': 0.27, 'EPS growth quarter over quarter': 0.483, 'Performance (Quarter)': -0.1321, '200-Day Simple Moving Average': -0.2118, 'Shares Outstanding': 2.5, 'Earnings Date': datetime.datetime(2013, 11, 4, 5, 0), '52-Week High': -0.4956, 'P/Cash': 0.1, 'Change': 0.0358, 'Analyst Recom': 3, 'Volatility (Week)': 0.0508, 'Country': 'USA', 'Return on Equity': -0.147, '50-Day Low': 0.081, 'Price': 3.47, '50-Day High': -0.2078, 'Return on Investment': 0.161, 'Shares Float': 1.72, 'Industry': 'Regional - Southeast Banks', 'Beta': 0.83, 'Sales growth quarter over quarter': -0.14, 'Operating Margin': -0.18, 'EPS (ttm)': -2.22, 'Float Short': 0.0085, '52-Week Low': 1.3767, 'Average True Range': 0.12, 'Sales growth past 5 years': -0.096, 'Company': 'Atlantic Coast Financial Corporation', 'Gap': 0.0358, 'Relative Volume': 0, 'Volatility (Month)': 0.0228, 'Market Cap': 8.39, 'Volume': 0, 'Short Ratio': 6.07, 'Performance (Half Year)': -0.3667, 'Relative Strength Index (14)': 40.71, 'Insider Ownership': 0.001, '20-Day Simple Moving Average': -0.0742, 'Performance (Month)': -0.1138, 'Institutional Transactions': -4.3825, 'Performance (Year)': 0.7539, 'LT Debt/Equity': 0, 'Average Volume': 2.41, 'EPS growth this year': 0.354, '50-Day Simple Moving Average': -0.0993} 
    
    {'_id': ObjectId('52853800bb1177ca391c182f'), 'Ticker': 'ACH', 'Profit Margin': -0.051, 'Institutional Ownership': 0.02, 'EPS growth past 5 years': -0.227, 'Total Debt/Equity': 2.84, 'Current Ratio': 0.7, 'Return on Assets': -0.039, 'Sector': 'Basic Materials', 'P/S': 0.19, 'Change from Open': -0.0032, 'Performance (YTD)': -0.2645, 'Performance (Week)': -0.0437, 'Quick Ratio': 0.7, 'P/B': 0.67, 'EPS growth quarter over quarter': 0.711, 'Performance (Quarter)': 0.0057, '200-Day Simple Moving Average': -0.0544, 'Shares Outstanding': 540.98, 'Earnings Date': datetime.datetime(2011, 3, 2, 5, 0), '52-Week High': -0.3369, 'P/Cash': 2.77, 'Change': 0.0059, 'Analyst Recom': 5, 'Volatility (Week)': 0.015, 'Country': 'China', 'Return on Equity': -0.172, '50-Day Low': 0.0176, 'Price': 8.81, '50-Day High': -0.1117, 'Return on Investment': -0.029, 'Shares Float': 156.18, 'Industry': 'Aluminum', 'Beta': 1.9, 'Sales growth quarter over quarter': 0.065, 'Operating Margin': -0.021, 'EPS (ttm)': -1.76, 'Float Short': 0.02, '52-Week Low': 0.2154, 'Average True Range': 0.2, 'EPS growth next year': 0.487, 'Sales growth past 5 years': 0.119, 'Company': 'Aluminum Corporation Of China Limited', 'Gap': 0.0091, 'Relative Volume': 1.05, 'Volatility (Month)': 0.0183, 'Market Cap': 4738.98, 'Volume': 78010, 'Gross Margin': 0.005, 'Short Ratio': 38.23, 'Performance (Half Year)': -0.124, 'Relative Strength Index (14)': 38.92, '20-Day Simple Moving Average': -0.0477, 'Performance (Month)': -0.0405, 'Institutional Transactions': -0.0063, 'Performance (Year)': -0.1577, 'LT Debt/Equity': 1.19, 'Average Volume': 81.57, 'EPS growth this year': 0.839, '50-Day Simple Moving Average': -0.0421} 
    
    {'_id': ObjectId('52853800bb1177ca391c1832'), 'Ticker': 'ACI', 'Profit Margin': -0.173, 'Institutional Ownership': 0.662, 'EPS growth past 5 years': -0.361, 'Total Debt/Equity': 1.97, 'Current Ratio': 3.5, 'Return on Assets': -0.058, 'Sector': 'Basic Materials', 'P/S': 0.28, 'Change from Open': -0.0372, 'Performance (YTD)': -0.4019, 'Performance (Week)': -0.0183, 'Quick Ratio': 3, 'Insider Transactions': 0.0178, 'P/B': 0.35, 'EPS growth quarter over quarter': -5.455, 'Performance (Quarter)': -0.0549, '200-Day Simple Moving Average': -0.1177, 'Shares Outstanding': 212.11, 'Earnings Date': datetime.datetime(2013, 10, 29, 12, 30), '52-Week High': -0.4702, 'P/Cash': 0.66, 'Change': -0.0372, 'Analyst Recom': 2.8, 'Volatility (Week)': 0.0516, 'Country': 'USA', 'Return on Equity': -0.207, '50-Day Low': 0.104, 'Price': 4.14, '50-Day High': -0.2114, 'Return on Investment': -0.047, 'Shares Float': 209.56, 'Dividend Yield': 0.0279, 'EPS growth next 5 years': 0.05, 'Industry': 'Industrial Metals & Minerals', 'Beta': 1.61, 'Sales growth quarter over quarter': -0.272, 'Operating Margin': -0.04, 'EPS (ttm)': -3.16, 'Float Short': 0.1772, '52-Week Low': 0.1997, 'Average True Range': 0.23, 'EPS growth next year': 0.143, 'Sales growth past 5 years': 0.115, 'Company': 'Arch Coal Inc.', 'Gap': 0, 'Relative Volume': 0.66, 'Volatility (Month)': 0.0546, 'Market Cap': 912.08, 'Volume': 5417562, 'Gross Margin': 0.141, 'Short Ratio': 4.12, 'Performance (Half Year)': -0.1224, 'Relative Strength Index (14)': 43.64, 'Insider Ownership': 0.0054, '20-Day Simple Moving Average': -0.0171, 'Performance (Month)': 0.0437, 'Institutional Transactions': 0.0024, 'Performance (Year)': -0.3741, 'LT Debt/Equity': 1.97, 'Average Volume': 9000.5, 'EPS growth this year': -5.378, '50-Day Simple Moving Average': -0.0482} 
    
    

6) Renomeie o campo “Profit Margin” para apenas “profit”.


```python
stocks.update({}, {"$rename": {"Profit Margin": "profit"}}, False, True)
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:1: DeprecationWarning: update is deprecated. Use replace_one, update_one or update_many instead.
      """Entry point for launching an IPython kernel.
    




    {'n': 1, 'nModified': 1, 'ok': 1.0, 'updatedExisting': True}



7) Agora liste apenas a empresa e seu respectivo resultado



```python
stocks.find_one()
```




    {'_id': ObjectId('52853800bb1177ca391c17ff'),
     'Ticker': 'A',
     'Institutional Ownership': 0.847,
     'EPS growth past 5 years': 0.158,
     'Total Debt/Equity': 0.56,
     'Current Ratio': 3,
     'Return on Assets': 0.089,
     'Sector': 'Healthcare',
     'P/S': 2.54,
     'Change from Open': -0.0148,
     'Performance (YTD)': 0.2605,
     'Performance (Week)': 0.0031,
     'Quick Ratio': 2.3,
     'Insider Transactions': -0.1352,
     'P/B': 3.63,
     'EPS growth quarter over quarter': -0.29,
     'Payout Ratio': 0.162,
     'Performance (Quarter)': 0.0928,
     'Forward P/E': 16.11,
     'P/E': 19.1,
     '200-Day Simple Moving Average': 0.1062,
     'Shares Outstanding': 339,
     'Earnings Date': datetime.datetime(2013, 11, 14, 21, 30),
     '52-Week High': -0.0544,
     'P/Cash': 7.45,
     'Change': -0.0148,
     'Analyst Recom': 1.6,
     'Volatility (Week)': 0.0177,
     'Country': 'USA',
     'Return on Equity': 0.182,
     '50-Day Low': 0.0728,
     'Price': 50.44,
     '50-Day High': -0.0544,
     'Return on Investment': 0.163,
     'Shares Float': 330.21,
     'Dividend Yield': 0.0094,
     'EPS growth next 5 years': 0.0843,
     'Industry': 'Medical Laboratories & Research',
     'Beta': 1.5,
     'Sales growth quarter over quarter': -0.041,
     'Operating Margin': 0.187,
     'EPS (ttm)': 2.68,
     'PEG': 2.27,
     'Float Short': 0.008,
     '52-Week Low': 0.4378,
     'Average True Range': 0.86,
     'EPS growth next year': 0.1194,
     'Sales growth past 5 years': 0.048,
     'Company': 'Agilent Technologies Inc.',
     'Gap': 0,
     'Relative Volume': 0.79,
     'Volatility (Month)': 0.0168,
     'Market Cap': 17356.8,
     'Volume': 1847978,
     'Gross Margin': 0.512,
     'Short Ratio': 1.03,
     'Performance (Half Year)': 0.1439,
     'Relative Strength Index (14)': 46.51,
     'Insider Ownership': 0.001,
     '20-Day Simple Moving Average': -0.0172,
     'Performance (Month)': 0.0063,
     'P/Free Cash Flow': 19.63,
     'Institutional Transactions': -0.0074,
     'Performance (Year)': 0.4242,
     'LT Debt/Equity': 0.56,
     'Average Volume': 2569.36,
     'EPS growth this year': 0.147,
     '50-Day Simple Moving Average': -0.0055,
     'profit': 0.137}



### Exercício 4: Fraude na Enron!


```python
enron = db['test']['enron']
enron.count()
```

    C:\Users\raffa\Anaconda3\lib\site-packages\ipykernel_launcher.py:2: DeprecationWarning: count is deprecated. Use estimated_document_count or count_documents instead. Please note that $where must be replaced by $expr, $near must be replaced by $geoWithin with $center, and $nearSphere must be replaced by $geoWithin with $centerSphere
      
    




    5929



1) Liste as pessoas que enviaram e-mails (de forma distinta, ou seja, sem repetir). Quantas pessoas são?


```python
sender = enron.aggregate([
    {"$group": { "_id": "$sender"}}
])
count = 0
for s in sender:
    print(s)
    count += 1
print("Total: ",count)
```

    {'_id': 'maryemackay@hotmail.com'}
    {'_id': '5f844eda@xmr3.com'}
    {'_id': 'jamie_okeefe@hotmail.com'}
    {'_id': 'jschwert@u.washington.edu'}
    {'_id': 'mccue@mdcsystems.com'}
    {'_id': 'tchuckel@eassist.com'}
    {'_id': 'john.zilker@enron.com'}
    {'_id': '1267@m2.innovyx.com'}
    {'_id': 'karen.white@csfb.com'}
    {'_id': 'anya_hoffman@gap.com'}
    {'_id': 'jan.c.dunn@dynegy.com'}
    {'_id': 'tsimmons@spencerstuart.com'}
    {'_id': 'steve@brokebox.com'}
    {'_id': 'diane.bazelides@enron.com'}
    {'_id': 'gene.humphrey@enron.com'}
    {'_id': 'treasa.kirby@enron.com'}
    {'_id': 'rebecca.mcdonald@enron.com'}
    {'_id': 'david.tonsall@enron.com'}
    {'_id': 'guaro712@aol.com'}
    {'_id': 'rahm@missouri.edu'}
    {'_id': 'iertx@hern.org'}
    {'_id': 'priya.jaisinghani@enron.com'}
    {'_id': 'bsears@law.harvard.edu'}
    {'_id': 'julieirish@earthlink.net'}
    {'_id': 'chaz2k2k@yahoo.com'}
    {'_id': 'dodfraser@aol.com'}
    {'_id': 'megadood_2000@yahoo.com'}
    {'_id': 'cbi_mail@igate.cbinet.com'}
    {'_id': 'jennifer@usenix.org'}
    {'_id': 'thedesk@scudderpublishing.com'}
    {'_id': 'david@smartstaffpersonnel.com'}
    {'_id': 'phobby@genesis-park.com'}
    {'_id': 'jverni4399@aol.com'}
    {'_id': 'thorsing@mctcnet.net'}
    {'_id': 'thriftyluxury@yahoo.com'}
    {'_id': 'wanda.holloway@compaq.com'}
    {'_id': 'rmberkowitz@att.net'}
    {'_id': 'mdaar@yahoo.com'}
    {'_id': 'kathleen_corcoran@holderness.org'}
    {'_id': 'gerri.gosnell@enron.com'}
    {'_id': 'todd.renaud@enron.com'}
    {'_id': 'tom.chapman@enron.com'}
    {'_id': 'alafave@houston.org'}
    {'_id': 'hrr@abdi.com'}
    {'_id': 'emily_dale@hotmail.com'}
    {'_id': 'anita.parker@cumins.com'}
    {'_id': 'charla.reese@enron.com'}
    {'_id': 'gabreim@earthlink.net'}
    {'_id': 'lovelem@hotmail.com'}
    {'_id': 'kapberg@aol.com'}
    {'_id': 'trollmntn@aol.com'}
    {'_id': 'dsjames@tribune.com'}
    {'_id': 'spykelley@aol.com'}
    {'_id': 'akumar@del2.vsnl.net.in'}
    {'_id': 'clark97@swbell.net'}
    {'_id': 'anastasia.aourik@enron.com'}
    {'_id': 'mhoague@niton.com'}
    {'_id': 'ghultquist@hultquistcapital.com'}
    {'_id': 'milder.mcgee@verizon.net'}
    {'_id': 'robert.smith@enron.com'}
    {'_id': 'rmelancon@simplecom.net'}
    {'_id': 'gpmaloney@yahoo.com'}
    {'_id': 'megawatt@starband.net'}
    {'_id': 'hank.hilliard@purgit.com'}
    {'_id': 'bollles@aol.com'}
    {'_id': 'savoycap@email.msn.com'}
    {'_id': 'office@eapassaic.org'}
    {'_id': 'saabson@yahoo.com'}
    {'_id': 'kmbain@earthlink.net'}
    {'_id': 'robin_gunter@i2.com'}
    {'_id': 'jrm@laplaza.org'}
    {'_id': 'jana.paxton@enron.com'}
    {'_id': 'clarkej510@earthlink.net'}
    {'_id': 'jhitchi@hotmail.com'}
    {'_id': 'p_t_w@hotmail.com'}
    {'_id': 'halton@mail.utexas.edu'}
    {'_id': 'ezzy622@yahoo.com'}
    {'_id': 'mario.brunasso@enron.com'}
    {'_id': 'ellis@fix.net'}
    {'_id': 'kdf@fidalgo.net'}
    {'_id': 'kaye63@earthlink.net'}
    {'_id': 'bsc123@rogers.com'}
    {'_id': 'bamoroso@wfubmc.edu'}
    {'_id': 'eric.letke@enron.com'}
    {'_id': 'mreynolds@yahoo.com'}
    {'_id': 'debbie.riall@enron.com'}
    {'_id': 'lhelper@wafs.com'}
    {'_id': 'calenehsvp@aol.com'}
    {'_id': 'dlmckay@duke.edu'}
    {'_id': 'tim.despain@enron.com'}
    {'_id': 'stundermann@hampshire.edu'}
    {'_id': 'aprilhoover@msn.com'}
    {'_id': 'elyse.kalmans@enron.com'}
    {'_id': 'richie@richieunterberger.com'}
    {'_id': 'breakingnews@mail.cnn.com'}
    {'_id': 'westcoastwren@hotmail.com'}
    {'_id': 'jimbrulte@aol.com'}
    {'_id': 'lists@nbr.org'}
    {'_id': 'jrrah@hotmail.com'}
    {'_id': 'john.ambler@enron.com'}
    {'_id': 'enron_update@concureworkplace.com'}
    {'_id': 'wilma.williams@enron.com'}
    {'_id': 'golden_charles_e@lilly.com'}
    {'_id': 'dgivens@intellibridge.com'}
    {'_id': 'icare87855@aol.com'}
    {'_id': 'sprucie@hotmail.com'}
    {'_id': 'mmfoss@uh.edu'}
    {'_id': 'magnolia3@earthlink.net'}
    {'_id': 'ejones363@attbi.com'}
    {'_id': 'arianna_king@rsconst.com'}
    {'_id': 'donohue@uschamber.com'}
    {'_id': 'kinhbui@aol.com'}
    {'_id': 'limpert@ncqa.org'}
    {'_id': 'jccanman@email.unc.edu'}
    {'_id': 'brian.skruch@reddotsolutions.com'}
    {'_id': 'georgene.moore@enron.com'}
    {'_id': 'mmichalk@houston.rr.com'}
    {'_id': 'bens01119@yahoo.com'}
    {'_id': 'wewerlacy@aol.com'}
    {'_id': 'bwalker@gcauniforms.com'}
    {'_id': 'iengelhardt@peabodyenergy.com'}
    {'_id': 'flumiani1@aol.com'}
    {'_id': 'music@as-coa.org'}
    {'_id': 'rofravi@aol.com'}
    {'_id': 'sean.riordan@enron.com'}
    {'_id': 'egirlinc@yahoo.com'}
    {'_id': 'tdh@y2kenergy.net'}
    {'_id': 'cchun@calstatela.edu'}
    {'_id': 'frankeed@hotmail.com'}
    {'_id': 'kathryn.schultea@enron.com'}
    {'_id': 'jackd@dmcmgmt.com'}
    {'_id': 'jeffrey.mcclellan@enron.com'}
    {'_id': 'duchess6206@yahoo.com'}
    {'_id': '2586207@www4.imakenews.com'}
    {'_id': 'jay_galston@yahoo.com'}
    {'_id': 'greenbus@pacbell.net'}
    {'_id': 'jenikadoctor@hotmail.com'}
    {'_id': 'marcia_aronoff@environmentaldefense.org'}
    {'_id': 'zach.moring@enron.com'}
    {'_id': 'jacobsenp@fsl.orst.edu'}
    {'_id': 'nlay@att.net'}
    {'_id': 'sailoret_2000@yahoo.com'}
    {'_id': 'ssurasky@yahoo.com'}
    {'_id': 'sandyh715@juno.com'}
    {'_id': 'nexustechn@processrequest.com'}
    {'_id': 'alevwho@mediaone.net'}
    {'_id': 'crown@northwestern.edu'}
    {'_id': 'alfredo@dvinci.net'}
    {'_id': 'daveh@pacmed.org'}
    {'_id': 'doyle@rff.org'}
    {'_id': 'rosenthal@heaneyrosenthal.com'}
    {'_id': 'samcg1@aol.com'}
    {'_id': 'jtompkins1@houston.rr.com'}
    {'_id': 'tgarza@onr.com'}
    {'_id': 'grace.trent@compaq.com'}
    {'_id': 'john.allison@enron.com'}
    {'_id': 'callas@tcwgroup.com'}
    {'_id': 'caroll2506@aol.com'}
    {'_id': 'levine_dan@hotmail.com'}
    {'_id': 'terri_laine@patagonia.com'}
    {'_id': 'dean_gross@frankel.com'}
    {'_id': 'mail@triactive.com'}
    {'_id': 'mingchenglian@aol.com'}
    {'_id': 'royalty@vsnl.com'}
    {'_id': 'rubine@flash.net'}
    {'_id': 'smabblymedium@hotmail.com'}
    {'_id': 'bianca_hayes@hotmail.com'}
    {'_id': 's..presas@enron.com'}
    {'_id': 'mnw@cockrell.com'}
    {'_id': 'christopherszell@yahoo.com'}
    {'_id': 'andy.blanchard@enron.com'}
    {'_id': 'msaade@uwtgc.org'}
    {'_id': 'chrissyanthro@aol.com'}
    {'_id': 'sherri.sera@enron.com'}
    {'_id': 'kali@ix.netcom.com'}
    {'_id': 'david@carbonflux.org'}
    {'_id': 'kevin.hannon@enron.com'}
    {'_id': 'jsamuelson@aspeninstitute.org'}
    {'_id': 'danny.mccarty@enron.com'}
    {'_id': 'mcnamarg@ummhc.org'}
    {'_id': 'slichtenstein@frenchx2.com'}
    {'_id': 'lindheimer@yahoo.com'}
    {'_id': 'noah@stentor.com'}
    {'_id': 'momchristo@aol.com'}
    {'_id': 'sfsiren@yahoo.com'}
    {'_id': 'wposource@wpo.org'}
    {'_id': 'deane.pierce@enron.com'}
    {'_id': 'lindsay@enron.com'}
    {'_id': 'wjheilman@worldnet.att.net'}
    {'_id': 'sfink@knowledgeu.com'}
    {'_id': 'kayla.crenshaw@enron.com'}
    {'_id': 'chonch222@hotmail.com'}
    {'_id': 'thavell@aclu-il.org'}
    {'_id': 'mteisan@aol.com'}
    {'_id': 'jngoodman@ncpa.org'}
    {'_id': 'kquandt@onebox.com'}
    {'_id': 'bill.gathmann@enron.com'}
    {'_id': 'aburman@earthlink.net'}
    {'_id': 'earley1@hotmail.com'}
    {'_id': 'annatjain@hotmail.com'}
    {'_id': 'pjarond@hotmail.com'}
    {'_id': 'muhreuh@yahoo.com'}
    {'_id': 'mpowell@nmfiber.com'}
    {'_id': 'svadas@yahoo.com'}
    {'_id': 'gd@skycastle.net'}
    {'_id': 'christoph.frei@weforum.org'}
    {'_id': 'regina.karsolich@enron.com'}
    {'_id': 'michael.harris@enron.com'}
    {'_id': 'eannouncement70@mailcity.com'}
    {'_id': 'lhuddleston@university-health-sys.com'}
    {'_id': 'pinkyscout@yahoo.com'}
    {'_id': 'khristina.griffin@enron.com'}
    {'_id': 'sharon@travelpark.com'}
    {'_id': 'collage@igc.org'}
    {'_id': 'vcleveland@spacehab.com'}
    {'_id': 'brenda.anderson@enron.com'}
    {'_id': 'dadnick@mediaone.net'}
    {'_id': 'tour@rice.edu'}
    {'_id': 'daniel.allegretti@enron.com'}
    {'_id': 'nancyobiz@aol.com'}
    {'_id': 'steven.alexander@us.artemisintl.com'}
    {'_id': 'boycebrian@hotmail.com'}
    {'_id': 'timothy.hubbard@enron.com'}
    {'_id': 'ptmather@aol.com'}
    {'_id': 'johnny_wow@yahoo.com'}
    {'_id': 'rschmitt@csbsju.edu'}
    {'_id': '25465@www.brook.edu'}
    {'_id': 'rex.rogers@enron.com'}
    {'_id': 'csaltsman@nrsc.org'}
    {'_id': 'steven.kean@enron.com'}
    {'_id': 'skeeters@telepath.com'}
    {'_id': 'verlene.joseph@do.treas.gov'}
    {'_id': 'raissa.holt@blueshieldca.com'}
    {'_id': 'kevin.hyatt@enron.com'}
    {'_id': 'lavergne_schwender@co.harris.tx.us'}
    {'_id': 'ratna@everestinc.com'}
    {'_id': 'cdcboy@aol.com'}
    {'_id': 'baileatha@aol.com'}
    {'_id': 'lizard6849@yahoo.com'}
    {'_id': 'lregopoulos@aei.org'}
    {'_id': 'chegarty@dataway.com'}
    {'_id': 'gina.bess@mail.state.ky.us'}
    {'_id': 'rtunstall@csis.org'}
    {'_id': 'thesmodge@hotmail.com'}
    {'_id': 'rwsiii@ibpcorp.com'}
    {'_id': 'jlash@wri.org'}
    {'_id': 'kelli.fulton@mail.house.gov'}
    {'_id': 'sbason@dataprose.com'}
    {'_id': 'klesinsk@uiuc.edu'}
    {'_id': 'gael.doar@enron.com'}
    {'_id': 'thomas_f_zwiesler@uhc.com'}
    {'_id': 'vincent.wagner@enron.com'}
    {'_id': 'eradicator_97@hotmail.com'}
    {'_id': 'cengel@apk.net'}
    {'_id': 'farenaud@sover.net'}
    {'_id': 'john@up-mag.com'}
    {'_id': 'shanaynay83@hotmail.com'}
    {'_id': 'msorrell@wpp.com'}
    {'_id': 'aeplager@yahoo.com'}
    {'_id': 'danesmommy0702@msn.com'}
    {'_id': 'kneese@regis.edu'}
    {'_id': 'mikefwmi@aol.com'}
    {'_id': 'noelle_teagno@hotmail.com'}
    {'_id': 'jmboard@qwest.net'}
    {'_id': 'julie.clyatt@enron.com'}
    {'_id': 'janet.dietrich@enron.com'}
    {'_id': 'kelsey02@hotmail.com'}
    {'_id': 'pramath_sinha@mckinsey.com'}
    {'_id': 'mtcandyjar@aol.com'}
    {'_id': 'jim@sea-change.org'}
    {'_id': 'bobs@independentsector.org'}
    {'_id': 'brevnov@starpower.net'}
    {'_id': 'jharwood@mindspring.com'}
    {'_id': 'tobrien8@depaul.edu'}
    {'_id': 'gwyn.koepke@enron.com'}
    {'_id': 'kluersse@indiana.edu'}
    {'_id': 'delas@aol.com'}
    {'_id': 'sabaabc@yahoo.com'}
    {'_id': 'davidshult@juno.com'}
    {'_id': 'sbeck9@msn.com'}
    {'_id': 'ekelly65@yahoo.com'}
    {'_id': 'agbriggs@adamswells.com'}
    {'_id': 'annie_moore@yahoo.com'}
    {'_id': 'david.truncale@enron.com'}
    {'_id': 'prince@northwestern.edu'}
    {'_id': 'eric@aperia.com'}
    {'_id': 'efm4@cornell.edu'}
    {'_id': 'tomicamachouston@aol.com'}
    {'_id': 'joe@lyric.org'}
    {'_id': 'maryhelen@igainc.com'}
    {'_id': 'pat_mac@pacbel.net'}
    {'_id': 'c..knightstep@enron.com'}
    {'_id': 'grcmwebmaster@mail.house.gov'}
    {'_id': 'cchristensen@bctgm.org'}
    {'_id': 'stanley.horton@enron.com'}
    {'_id': 'jschacht@schachtandassociates.com'}
    {'_id': 'missy.stevens@enron.com'}
    {'_id': 'svarga@kudlow.com'}
    {'_id': 'cynthia.barrow@enron.com'}
    {'_id': 'eric.thode@enron.com'}
    {'_id': 'chris.thrall@enron.com'}
    {'_id': 'annelaurance@mediaone.net'}
    {'_id': 'rosswork@cwia.com'}
    {'_id': 'giglets@hotmail.com'}
    {'_id': 'cshanbhogue@aol.com'}
    {'_id': 'enrique.zambrano@enron.com'}
    {'_id': 'anne@ran.org'}
    {'_id': 'ethics_integrity@hotmail.com'}
    {'_id': 'jharris@icmtalent.com'}
    {'_id': 'sbarnhill26@hotmail.com'}
    {'_id': 'k_browning@yahoo.com'}
    {'_id': 'mchiuten@twcny.rr.com'}
    {'_id': 'gary.bowers@eds.com'}
    {'_id': 'watson_wyatt_houston@watsonwyatt.com'}
    {'_id': 'pskatzdds@mediaone.net'}
    {'_id': 'fransmith42@aol.com'}
    {'_id': 'johndutton@earthlink.net'}
    {'_id': 'ashok.mehta@enron.com'}
    {'_id': 'ed.robinson@enron.com'}
    {'_id': 'tthrush@webnexus.com'}
    {'_id': 'lynn.kerman@umusic.com'}
    {'_id': 'rogers@taxfoundation.org'}
    {'_id': 'dcramer@as-coa.org'}
    {'_id': 'pflww@yahoo.com'}
    {'_id': 'lhead@juno.com'}
    {'_id': 'stanfordcary@hotmail.com'}
    {'_id': 'nhenson@houston.org'}
    {'_id': 'debbie.beavers@enron.com'}
    {'_id': 'peterlo@printrak.com'}
    {'_id': 'hamad3@aol.com'}
    {'_id': 'valerie@digitalmaven.net'}
    {'_id': 'caduran@hotmail.com'}
    {'_id': 'sfarrell65@yahoo.com'}
    {'_id': 'george.wasaff@enron.com'}
    {'_id': 'jeffrey.garten@yale.edu'}
    {'_id': 'thomkb@gte.net'}
    {'_id': 'jmagi@aol.com'}
    {'_id': 'julian.draven@turner.com'}
    {'_id': 'coleen.a.hanna@constellation.com'}
    {'_id': 'mmills@u.washington.edu'}
    {'_id': 'hardie.davis@enron.com'}
    {'_id': 'mbriney@stam.rc.com'}
    {'_id': 'janette@thermostatic.com'}
    {'_id': 'tammie.huthmacher@enron.com'}
    {'_id': 'kreinbring@yahoo.com'}
    {'_id': 'jefftamar@aol.com'}
    {'_id': 'dbartek@metropo.mccneb.edu'}
    {'_id': 'mike.croucher@enron.com'}
    {'_id': 'full.throttle@bigfoot.com'}
    {'_id': 'ljefferson@jefferson-usa.com'}
    {'_id': 'ravi.thuraisingham@enron.com'}
    {'_id': 'aweisbar@fas.harvard.edu'}
    {'_id': 'davidson@miami.edu'}
    {'_id': 'pmartin@azahner.com'}
    {'_id': 'matthew.allan@enron.com'}
    {'_id': 'griffith.owens@enron.com'}
    {'_id': 'mw696@columbia.edu'}
    {'_id': 'georgen@epenergy.com'}
    {'_id': 'maryse_zwick@weforum.org'}
    {'_id': 'artistchar@yahoo.com'}
    {'_id': 'bijangh2000@tavana.net'}
    {'_id': 'aoc@pacbell.net'}
    {'_id': 'michael.krautz@enron.com'}
    {'_id': 'michael.williams@rrc.state.tx.us'}
    {'_id': 'u@d.h'}
    {'_id': 'bretwalburg@hotmail.com'}
    {'_id': 'list@free-market.net'}
    {'_id': 'ken.rice@enron.com'}
    {'_id': 'daler.wade@enron.com'}
    {'_id': 'greta@globalvis.com'}
    {'_id': 'tanners4@earthlink.net'}
    {'_id': 'kenneth.lambert@enron.com'}
    {'_id': 'tracy.ralston@enron.com'}
    {'_id': 'mpbs@psu.edu'}
    {'_id': 'shea_dugger@i2.com'}
    {'_id': 'daboub1@airmail.net'}
    {'_id': 'ccidata@comcntr.com'}
    {'_id': 'pperry@sfts.edu'}
    {'_id': 'greg_priest@smartforce.com'}
    {'_id': 'judgev@aol.com'}
    {'_id': 'lsmith@togetherkc.org'}
    {'_id': 'bburke@rice.edu'}
    {'_id': 'lynn.nichols@equitysb.com'}
    {'_id': 's..smith@enron.com'}
    {'_id': 'mrslinda@lplpi.com'}
    {'_id': 'agray@newyork.bozell.com'}
    {'_id': 'ldumdum@ase.org'}
    {'_id': 'dreamscaip@hotmail.com'}
    {'_id': 'jessea@mediaone.net'}
    {'_id': 'alicia@allrecipes.com'}
    {'_id': 'diane@rnp.org'}
    {'_id': 'digbyk3@excite.com'}
    {'_id': 'lwarren@tcoek12.org'}
    {'_id': 'j..detmering@enron.com'}
    {'_id': 'anonymous@advicebox.com'}
    {'_id': 'selma_meyerowitz@yahoo.com'}
    {'_id': 'pran.mehra@band-x.com'}
    {'_id': 'jeffrey.keeler@enron.com'}
    {'_id': 'ceoextra@houston.org'}
    {'_id': 'harrisondarling@aol.com'}
    {'_id': 'rcampo@camdenliving.com'}
    {'_id': 'jduffy@tides.org'}
    {'_id': 'calvin.eakins@enron.com'}
    {'_id': 'ml_research@ml.com'}
    {'_id': 'pgarner@ufl.edu'}
    {'_id': 'zanychris@hotmail.com'}
    {'_id': 'rossiumi@texas.net'}
    {'_id': 'kishorer@inventx.com'}
    {'_id': 'ckodner@stuart.k12.nj.us'}
    {'_id': 'grefford@ieee.org'}
    {'_id': 'j.zimmerman@snhu.edu'}
    {'_id': 'atrebin@luc.edu'}
    {'_id': 'lorijosephson@masn.com'}
    {'_id': 'karenlemes@earthlink.net'}
    {'_id': 'd@piassick'}
    {'_id': 'lisa.gillette@enron.com'}
    {'_id': 'jnissl@healthwise.org'}
    {'_id': 'fahmed74@yahoo.com'}
    {'_id': 'manastassatos@randomhouse.com'}
    {'_id': 'boulder445@aol.com'}
    {'_id': 'ann.stagg@biosgroup.com'}
    {'_id': 'pn21@qwest.net'}
    {'_id': 'cratmiami@aol.com'}
    {'_id': 'philip.rhind@za.hsbcib.com'}
    {'_id': 'handsheal52@earthlink.net'}
    {'_id': 'hazelm@reninet.com'}
    {'_id': 'cindy.olson@enron.com'}
    {'_id': 'mdeminsky@crisisclinic.org'}
    {'_id': 'ahockman2@attbroadband.com'}
    {'_id': 'daveroochvarg@erols.com'}
    {'_id': 'pagoo2@webtv.net'}
    {'_id': 'edelste2@niehs.nih.gov'}
    {'_id': 'tschlener@fginc.com'}
    {'_id': 'scc@rice.edu'}
    {'_id': 'jvondrak@aol.com'}
    {'_id': 'paula.rieker@enron.com'}
    {'_id': 'globalbrain2000@yahoo.com'}
    {'_id': 'tony_eng@netcel360.com'}
    {'_id': 'michelle.nelson@enron.com'}
    {'_id': 'jeffrey.mcmahon@enron.com'}
    {'_id': 'hgreenebaum@primediabusiness.com'}
    {'_id': 'w5ku@aol.com'}
    {'_id': 'mitesh.master@enron.com'}
    {'_id': 'khalidaalireza@xenel.com'}
    {'_id': 'irene.flynn@enron.com'}
    {'_id': 'thamman1@earthlink.net'}
    {'_id': 'tom.glassanos@xign.com'}
    {'_id': 'shawnt@coralweb.com'}
    {'_id': 'tlittleman@aol.com'}
    {'_id': 'briond@aja.com'}
    {'_id': 'spencer.120@osu.edu'}
    {'_id': 'art@mycfo.com'}
    {'_id': 'mcsager@mindspring.com'}
    {'_id': 'robbetz@webtv.net'}
    {'_id': 'mswanson@raritanval.edu'}
    {'_id': 'hbaum73@hotmail.com'}
    {'_id': 'peggy.mahoney@enron.com'}
    {'_id': 'fehring@aloha.net'}
    {'_id': 'chelfert@aol.com'}
    {'_id': 'chairman.ken@enron.com'}
    {'_id': 'alishec@aol.com'}
    {'_id': 'john.gore@enron.com'}
    {'_id': 'raangus@bellsouth.net'}
    {'_id': 'jepress@aol.com'}
    {'_id': 'gitfunkee@yahoo.com'}
    {'_id': 'robrob731@yahoo.com'}
    {'_id': 'robberbaronusa@yahoo.com'}
    {'_id': 'gentile@bolt.com'}
    {'_id': 'mcneillyd@aol.com'}
    {'_id': 's_shatila@hotmail.com'}
    {'_id': 'ksance@swbell.net'}
    {'_id': 'mary_dolan@umit.maine.edu'}
    {'_id': 'antoinetteml@yahoo.com'}
    {'_id': 'sanjay.bhatnagar@enron.com'}
    {'_id': 'eworzero@netscape.net'}
    {'_id': 'mary.bourne@showtime.net'}
    {'_id': 'bbolwerk@hotmail.com'}
    {'_id': 'ahaws@austin.rr.com'}
    {'_id': 'a..davis@enron.com'}
    {'_id': 'jdavis50@earthlink.net'}
    {'_id': 'marilyn.chalmers@compaq.com'}
    {'_id': 'jgedwards@hotmail.com'}
    {'_id': 'linda@onboard.com'}
    {'_id': 'robngreg@yahoo.com'}
    {'_id': 'cmoore@moline.lth2.k12.il.us'}
    {'_id': 'martin.gonzalez@enron.com'}
    {'_id': 'astevenson@ida.net'}
    {'_id': 'andrew.kosnaski@enron.com'}
    {'_id': 'jkrags@hotmail.com'}
    {'_id': 'aviblack@yahoo.com'}
    {'_id': 'bruce@sustainableharvest.org'}
    {'_id': 'slong@exodusenergy.com'}
    {'_id': 'kitty.colgin@compaq.com'}
    {'_id': 'msyentah@aol.com'}
    {'_id': 'pbothwel@indiana.edu'}
    {'_id': 'sem@coral.ocn.ne.jp'}
    {'_id': 'annat@thotcapital.com'}
    {'_id': 'tiptonhr@yahoo.com'}
    {'_id': 'jamie@prosperpoint.com'}
    {'_id': 'tfakp@aol.com'}
    {'_id': 'barbette_watts@i2.com'}
    {'_id': 'edwardondarza@hotmail.com'}
    {'_id': 'vickiryder@juno.com'}
    {'_id': 'mackimmy@oc-net.com'}
    {'_id': 'cecil.stinemetz@enron.com'}
    {'_id': 'brian.redmond@enron.com'}
    {'_id': 'philip.andrew@stanfordalumni.org'}
    {'_id': 'james.noles@enron.com'}
    {'_id': 'vera.jones@enron.com'}
    {'_id': 'rfrank@doil.com'}
    {'_id': 'jwillis@wafs.com'}
    {'_id': 'sgoins@fibrogen.com'}
    {'_id': 'ayw@georgetown.edu'}
    {'_id': 'chrishomsey@yahoo.com'}
    {'_id': 'vjillh@hotmail.com'}
    {'_id': 'shelly.mansfield@enron.com'}
    {'_id': 'louis@balanceconsult.com'}
    {'_id': 'jhr@visionquestinc.com'}
    {'_id': 'cscusack@email.msn.com'}
    {'_id': 'hamelv@arentfox.com'}
    {'_id': 'richard.jones@enron.com'}
    {'_id': 'mark.metts@enron.com'}
    {'_id': 'a..schroeder@enron.com'}
    {'_id': 'ibuyit.payables@enron.com'}
    {'_id': 'rsant@aesc.com'}
    {'_id': 'trimind@aol.com'}
    {'_id': 'samberkovits@yahoo.com'}
    {'_id': 'jcollins@as.arizona.edu'}
    {'_id': 'charl_cer@hotmail.com'}
    {'_id': 'dsilvers@aflcio.org'}
    {'_id': 'steven_fallt@pgn.com'}
    {'_id': 'grnthumb@ipa.netf'}
    {'_id': 'maxwells@train.missouri.org'}
    {'_id': 'gravellle@napanet.net'}
    {'_id': 'd.olson@bigfoot.com'}
    {'_id': 'pnewton@whrarchitects.com'}
    {'_id': 'hema@izhuta.com'}
    {'_id': 'pamela.blazick@isinet.com'}
    {'_id': 'erik@desart.com'}
    {'_id': 'officeofthechairman2@enron.com'}
    {'_id': 'globalvoice@globalpartnerships.org'}
    {'_id': 'hburnette@neo.rr.com'}
    {'_id': 'adesioye@u-t-g.de'}
    {'_id': 'event@aei.org'}
    {'_id': 'mrlevin@student.umass.edu'}
    {'_id': 'caribbeancari@yahoo.com'}
    {'_id': 'leonardo.pacheco@enron.com'}
    {'_id': 'dls@corcoran.com'}
    {'_id': 'elnsie@gte.net'}
    {'_id': 'judynleon@prodigy.net'}
    {'_id': 'jpeaceimagine@aol.com'}
    {'_id': 'rsvitkay@webtv.net'}
    {'_id': 'dyergin@cera.com'}
    {'_id': 'patrwalke@earthlink.net'}
    {'_id': 'potempa@kingwoodcable.com'}
    {'_id': 'jkohler2@earthlink.net'}
    {'_id': 'anna_norville@hotmail.com'}
    {'_id': 'cklabrenz@earthlink.net'}
    {'_id': 'mark.hudgens@enron.com'}
    {'_id': 'roberto.volonte@enron.com'}
    {'_id': 'lisa.iannotti@enron.com'}
    {'_id': 'chris.connelly@enron.com'}
    {'_id': 'greg.piper@enron.com'}
    {'_id': 'a.c.fullilove@ieee.org'}
    {'_id': 'psagman@murrayinc.net'}
    {'_id': 'cpbartle@aol.com'}
    {'_id': 'nblanchard@sehinc.com'}
    {'_id': 'chad_modad@enron.net'}
    {'_id': 'ckbeeler@msn.com'}
    {'_id': 'vbhat@tatahousing.com'}
    {'_id': 'rtorres@argolink.net'}
    {'_id': 'jan_levine@travisintl.com'}
    {'_id': 'jduhart@omm.com'}
    {'_id': 'bmitchell@chaindrugstore.com'}
    {'_id': 'mark.fereday@enron.com'}
    {'_id': 'riofish@mac.com'}
    {'_id': 'nhrubin@utmb.edu'}
    {'_id': 'rune.ehwaz@verizon.net'}
    {'_id': 'kkubzdela@csc.cps.k12.il.us'}
    {'_id': 'sharon.lay@travelpark.com'}
    {'_id': 'judyb@tamu.edu'}
    {'_id': 'public.relations@enron.com'}
    {'_id': 'mschulzsd@aol.com'}
    {'_id': 'mtelle@velaw.com'}
    {'_id': 'ckappaz@mac.com'}
    {'_id': 'guelaguetza@club.lemonde.fr'}
    {'_id': 'josh.duncan@enron.com'}
    {'_id': 'shelley.farias@enron.com'}
    {'_id': 'abramson@cami.com'}
    {'_id': 'mikeb@baselice.com'}
    {'_id': 'chris_doner@dstoutput.com'}
    {'_id': 'eric@aquaticandwetland.com'}
    {'_id': 'allibakke@hotmail.com'}
    {'_id': 'pranaygupte@aol.com'}
    {'_id': 'david.haug@enron.com'}
    {'_id': 'tally@ssprd2.net'}
    {'_id': 'msimpson@wafs.com'}
    {'_id': 'suzanne.adams@enron.com'}
    {'_id': 'anna_ball@patagonia.com'}
    {'_id': 'cs3523@hotmail.com'}
    {'_id': 'lissawolf@hotmail.com'}
    {'_id': 'mwolff@english.umass.edu'}
    {'_id': 'gargravi@hotmail.com'}
    {'_id': 'rick_wallace@notes.amdahl.com'}
    {'_id': 'giancarloqui@aol.com'}
    {'_id': 'offers@mail.gravitydirect.net'}
    {'_id': 'klarus@sbsc.org'}
    {'_id': 'kkvw@mcn.org'}
    {'_id': 'jgerard1@rcnchicago.com'}
    {'_id': 'array@ssprd2.net'}
    {'_id': 'chill@lrmlaw.com'}
    {'_id': 'diaphone@earthlink.net'}
    {'_id': 'bromero@sdlintl.com'}
    {'_id': 'nevart2000@yahoo.com'}
    {'_id': 'jeffrey.sherrick@enron.com'}
    {'_id': 'erun@webaccess.net'}
    {'_id': 'ssoles@ziffenergy.com'}
    {'_id': 'johnposton@postonyoder.com'}
    {'_id': 'dplum@socrates.berkeley.edu'}
    {'_id': 'jillhowevercos@msn.com'}
    {'_id': 'timothy.vail@enron.com'}
    {'_id': 'mash4077@mediaone.net'}
    {'_id': 'srenino@netscape.net'}
    {'_id': 'sarinalesieur@hotmail.com'}
    {'_id': 'jhdiv@binswanger.com'}
    {'_id': 'c.farley@trade-ranger.com'}
    {'_id': 'marsha_j_b@yahoo.com'}
    {'_id': 'ginger.bissey@enron.com'}
    {'_id': 'peter.ruiz@artistdirect.com'}
    {'_id': 'voter@stevefarthing.com'}
    {'_id': 'ms@skyradionet.com'}
    {'_id': 'glenn.mcinnes@managementvitality.com'}
    {'_id': 'markkman6@yahoo.com'}
    {'_id': 'melindau@sover.net'}
    {'_id': 'jhunter@wei.org'}
    {'_id': 'gary@cioclub.com'}
    {'_id': 'adamk@nepco.com'}
    {'_id': 'abuchanan@diversa.com'}
    {'_id': 'kurtandrewkaiser@hotmail.com'}
    {'_id': 'ts3199@yahoo.com'}
    {'_id': 'bartvonsimpson@aol.com'}
    {'_id': 'kmcginty@natsource.com'}
    {'_id': 'sadger@tampabay.rr.com'}
    {'_id': 'luca@daimon.it'}
    {'_id': 'jcbellavance@yahoo.com'}
    {'_id': 'swthmchi@concentric.net'}
    {'_id': 'jelyons2@hotmail.com'}
    {'_id': 'weyoung@earthlink.net'}
    {'_id': 'aefurcht@facstaff.wisc.edu'}
    {'_id': 'norm.spalding@enron.com'}
    {'_id': 'sarahkeech@yahoo.com'}
    {'_id': 'marilynr@northv.com'}
    {'_id': 'hasan.kedwaii@enron.com'}
    {'_id': 'jwg101@aol.com'}
    {'_id': 'counciloftheamericas@as-coa.org'}
    {'_id': 'lsexton@tostevin.com'}
    {'_id': 'cgiovann@aol.com'}
    {'_id': 'jane@sieblerhome.fsnet.co.uk'}
    {'_id': 'althouses@aol.com'}
    {'_id': 'veggiemama247@hotmail.com'}
    {'_id': 'rod.williams@enron.com'}
    {'_id': 'wpage@speakeasy.net'}
    {'_id': 'pat.hoag@colaik.com'}
    {'_id': 'extensity@processrequest.com'}
    {'_id': 'bobbie.power@enron.com'}
    {'_id': 'angiebray@earthlink.net'}
    {'_id': 'michael.hicks@enron.com'}
    {'_id': 'bekurtz@ilstu.edu'}
    {'_id': 'vskirk@hotmail.com'}
    {'_id': 'kmalachi@howard.edu'}
    {'_id': 'mhollifi@mail.smu.edu'}
    {'_id': 'tandress@breitburn.com'}
    {'_id': 'bi_updates@www.brookings.org'}
    {'_id': 'kskinney@hotmail.com'}
    {'_id': 'l..wells@enron.com'}
    {'_id': 'joehillings@aol.com'}
    {'_id': 'velvet.sugarek@enron.com'}
    {'_id': 'helen.tunley@gs.com'}
    {'_id': 'janetoro@webtv.net'}
    {'_id': 'robearin@yahoo.com'}
    {'_id': 'rdorr01@earthlink.net'}
    {'_id': 'jeff_nolan@yahoo.com'}
    {'_id': 'jashat1@netscape.net'}
    {'_id': 'dorothy.mccoppin@enron.com'}
    {'_id': 'nanking1224@earthlink.net'}
    {'_id': 'rlorentzen@albertson.edu'}
    {'_id': 'walker@missouri.edu'}
    {'_id': 'news@ibcuk.co.uk'}
    {'_id': 'webmaster@iif.com'}
    {'_id': 'dflaux@ema2000.ch'}
    {'_id': 'sbeacom@mcsheaco.com'}
    {'_id': 'esposito@artcenter.edu'}
    {'_id': 'stefan@hopechild.com'}
    {'_id': 'mv94014@alltel.net'}
    {'_id': 'kazumtv@juno.com'}
    {'_id': 'kburroughs@palmeragency.com'}
    {'_id': 'billverdier@aol.com'}
    {'_id': 'robinparsons@earthlink.net'}
    {'_id': 'iambic@aol.com'}
    {'_id': 'ronboz_1977@yahoo.com'}
    {'_id': 'kenneth.feinleib@riag.com'}
    {'_id': 'jsokolsky@emphasysworld.com'}
    {'_id': 'tclark@thecwcgroup.com'}
    {'_id': 'core1111@go.com'}
    {'_id': 'moseley_l@piedmont.tec.sc.us'}
    {'_id': 'james.schiro@us.pwcglobal.com'}
    {'_id': 'dena.grady@ey.com'}
    {'_id': 'jaeschke@marin.cc.ca.us'}
    {'_id': 'ginger.dernehl@enron.com'}
    {'_id': 'holly@layfam.com'}
    {'_id': 'sally.keepers@enron.com'}
    {'_id': 'hwc@cwnyc.com'}
    {'_id': 'kirbynrg@swbell.net'}
    {'_id': 'razelg@aol.com'}
    {'_id': 'badether@yahoo.com'}
    {'_id': 'simonsays@har.com'}
    {'_id': 'apeterson@wildoats.com'}
    {'_id': 'wjrehm@yahoo.com'}
    {'_id': 'freeair@flash.net'}
    {'_id': 'jhduncan@aol.com'}
    {'_id': 'health_africa@yahoo.com'}
    {'_id': 'ahopp@mercator.com'}
    {'_id': 'elizabeth.davis@compaq.com'}
    {'_id': 'larry@cyberiandesign.com'}
    {'_id': 'luvdusty@hotmail.com'}
    {'_id': 'sausalitodave@yahoo.com'}
    {'_id': 'pcassidy@businesscouncil.com'}
    {'_id': 'salome.kern@enron.com'}
    {'_id': 'susan.skarness@enron.com'}
    {'_id': 'genkigai@mindspring.com'}
    {'_id': 'susana_williams@hotmail.com'}
    {'_id': 'lonetoad13@ameritech.net'}
    {'_id': 'mlpdgrace@yahoo.com'}
    {'_id': 'donna.fulton@enron.com'}
    {'_id': 'dahmen.ann@mayo.edu'}
    {'_id': 'nettewick@yahoo.com'}
    {'_id': 'otterwear@yahoo.com'}
    {'_id': 'bgould@att.com'}
    {'_id': 'kjorgensen@wafs.com'}
    {'_id': 'sharron.cathey@compaq.com'}
    {'_id': 'lisashears@yahoo.com'}
    {'_id': 'looksee@rocketmail.com'}
    {'_id': 'jjmm@mediaone.net'}
    {'_id': 'pksinghji@hotmail.com'}
    {'_id': 'binkley.oxley@enron.com'}
    {'_id': 'editor@impactpress.com'}
    {'_id': 'warner@rff.org'}
    {'_id': 'stephen_on@hotmail.com'}
    {'_id': 'douglas.mcneill@verizon.net'}
    {'_id': 'jwadsack@wadsack-allen.com'}
    {'_id': 'colbyco1@jps.net'}
    {'_id': 'dianas@macho.com'}
    {'_id': 'low@wsj.com'}
    {'_id': 'pinckney@centerbrook.com'}
    {'_id': 'ohi_supporters@operationhope.org'}
    {'_id': 'juantontomatoe@yahoo.com'}
    {'_id': 'pythia8@cyburban.com'}
    {'_id': 'lisa.costello@enron.com'}
    {'_id': 'jeana_mac@yahoo.com'}
    {'_id': 'sfauthor@aol.com'}
    {'_id': 'hiltons@fbcc.com'}
    {'_id': 'dtharpe@mac1988.com'}
    {'_id': 'martin@rotman.utoronto.ca'}
    {'_id': 'mischiefandmagic@aol.com'}
    {'_id': 'cvaroquiers@yahoo.com'}
    {'_id': 'dolson@smileatyou.com'}
    {'_id': 'fquebbemann@the-beach.net'}
    {'_id': 'jwalk1_99@yahoo.com'}
    {'_id': 'christa.winfrey@enron.com'}
    {'_id': 'kenneth.booi@mirant.com'}
    {'_id': 'patti@mcds.org'}
    {'_id': 'richard.w.smalling@uth.tmc.edu'}
    {'_id': 'elizabeth.lay@enron.com'}
    {'_id': 'deb@econweb.com'}
    {'_id': 'esmith0908@aol.com'}
    {'_id': 'spitandimage@earthlink.net'}
    {'_id': 'fwolgel@azurix.com'}
    {'_id': 'kittels@bu.edu'}
    {'_id': 'tgorski@madisonenergy.com'}
    {'_id': 'sharon@secondsitestudio.com'}
    {'_id': 'confadmin@ziffenergy.com'}
    {'_id': 'maria_papi@bstz.com'}
    {'_id': 'gary.buck@enron.com'}
    {'_id': 'nina.garcia@enron.com'}
    {'_id': 'ajax1642@planet-save.com'}
    {'_id': 'swillbanks@communityserviceinc.com'}
    {'_id': 'proactiveupdate@proactivenet.com'}
    {'_id': 'clynne5@hotmail.com'}
    {'_id': 'c_joey@msn.com'}
    {'_id': 'patton@aol.com'}
    {'_id': 'jennymc@train.missouri.org'}
    {'_id': 'marketing@triactive.com'}
    {'_id': 'savont@email.msn.com'}
    {'_id': 't.merrill@scievents.com'}
    {'_id': 'asiegel@questia.com'}
    {'_id': 'schumacherd@egehaina.com'}
    {'_id': 'clayton.seigle@enron.com'}
    {'_id': 'ezausner@yahoo.com'}
    {'_id': 'jbaldwin@aces.k12.ct.us'}
    {'_id': 'mommafont@aol.com'}
    {'_id': 'dcabello@questia.com'}
    {'_id': 'blauderback@soes.com'}
    {'_id': 's.ward.casscells@uth.tmc.edu'}
    {'_id': 'djunk_epc@yahoo.com'}
    {'_id': 'chantalb@atg.com'}
    {'_id': 'newpower.communication@newpower.com'}
    {'_id': 'ksgillmore@yahoo.com'}
    {'_id': 'rfriddle@setterleach.com'}
    {'_id': 'danandjen@charter.net'}
    {'_id': 'amanda.schear@juvcourt.hamilton-co.org'}
    {'_id': 'tdavidson1@davidsoncapital.com'}
    {'_id': 'bluehero@hotmail.com'}
    {'_id': 'lisa.hobbs@wessexwater.co.uk'}
    {'_id': 'david.oxley@enron.com'}
    {'_id': 'marlya0264@aol.com'}
    {'_id': 'jana.mills@enron.com'}
    {'_id': 'lorna@netopia.com'}
    {'_id': 'robert.gerry@enron.com'}
    {'_id': 'aurora.dimacali@enron.com'}
    {'_id': 'bevjahn@yahoo.com'}
    {'_id': 'rushingmk@surfmk.com'}
    {'_id': 'robert.saltiel@enron.com'}
    {'_id': 'tallen@mclarty.com'}
    {'_id': 'pwrighta@hotmail.com'}
    {'_id': 'rowaen@hotmail.com'}
    {'_id': 'corinne_tapia@bayh.senate.gov'}
    {'_id': 'carolflynnleah@yahoo.com'}
    {'_id': 'elizabeth.fredericks@hope.edu'}
    {'_id': 'imajerkoff@hotmail.com'}
    {'_id': 'kathy.johnson@enron.com'}
    {'_id': 'mzincs@aol.com'}
    {'_id': 'iam@michaelberry.com'}
    {'_id': 'nshaw@usenergyservices.com'}
    {'_id': 'pcoe@siweb.com'}
    {'_id': 'achowdhr@uschamber.com'}
    {'_id': 'cinthec@aol.com'}
    {'_id': 'cle_ese@speakeasy.net'}
    {'_id': 'mike.coleman@enron.com'}
    {'_id': 'dorothy.barnes@enron.com'}
    {'_id': 'zappencorser@hotmail.com'}
    {'_id': 'keri.lynch@usa.net'}
    {'_id': 'reidspice@hotmail.com'}
    {'_id': 'morgenalis@hotmail.com'}
    {'_id': 'debbie.doyle@enron.com'}
    {'_id': 'corry.bentley@enron.com'}
    {'_id': 'hdmd@downtowndistrict.org'}
    {'_id': 'afoster@hampshire.edu'}
    {'_id': 'nficara@wpo.org'}
    {'_id': 'katrinadvl@aol.com'}
    {'_id': 'nc@mmf.com'}
    {'_id': 'atandmh@earthlink.net'}
    {'_id': 'd_stayner@hadw.com'}
    {'_id': 'kathy_janeway@eogresources.com'}
    {'_id': 'mivancic@zoo.uvm.edu'}
    {'_id': 'jbinder@photofete.com'}
    {'_id': 'ttbp50@hotmail.com'}
    {'_id': 'marsha.shepherd@enron.com'}
    {'_id': 'nishiko@pacbell.net'}
    {'_id': 'tesssch30@hotmail.com'}
    {'_id': 'rita.ramirez@enron.com'}
    {'_id': 'andrea.yowman@enron.com'}
    {'_id': 'mark.carrie@mail.house.gov'}
    {'_id': 'dkobierowski@forrester.com'}
    {'_id': 'kingkoe@aol.com'}
    {'_id': 'wickedbill@yahoo.com'}
    {'_id': 'wylaya@cs.com'}
    {'_id': 'buckley@puc.state.pa.us'}
    {'_id': 'michelle.levinski@mail.tju.edu'}
    {'_id': 'john.hardy@enron.com'}
    {'_id': 'david_weekley@dwhomes.com'}
    {'_id': 'gary.fitch@enron.com'}
    {'_id': 'leah_weaver@hotmail.com'}
    {'_id': 'lsherriff@btinternet.com'}
    {'_id': 'energyvoice@txoga.org'}
    {'_id': 'melissacreations@aol.com'}
    {'_id': 'susiedeter@yahoo.com'}
    {'_id': 'claytor@purdue.edu'}
    {'_id': 'joru72@hotmail.com'}
    {'_id': 'larry.kelley@enron.com'}
    {'_id': 'abalaban@aei.org'}
    {'_id': 'bjktrone@aol.com'}
    {'_id': 'hollymartyn@hotmail.com'}
    {'_id': 'tgonchar@cats.ucsc.edu'}
    {'_id': 'factset@processrequest.com'}
    {'_id': 'v..monaghan@enron.com'}
    {'_id': 'hendrixdrh@aol.com'}
    {'_id': 'chayes@stc.com'}
    {'_id': 'dee007ram62@msn.com'}
    {'_id': 'sunie.ferrington@enron.com'}
    {'_id': 'creedon@rff.org'}
    {'_id': 'pdoyle@mathisgroup.com'}
    {'_id': 'whurt@cvalley.net'}
    {'_id': 'quigbe@aol.com'}
    {'_id': 'frank.semin@enron.com'}
    {'_id': 'david@bitstream.net'}
    {'_id': 'gil.muhl@enron.com'}
    {'_id': 'cary.shaw@bcbsma.com'}
    {'_id': 'jjenning@smith.edu'}
    {'_id': 'ben.glisan@enron.com'}
    {'_id': 'mckinsey_wef@mckinsey.com'}
    {'_id': 'johnnycakes_rising@hotmail.com'}
    {'_id': 'janet.butler@enron.com'}
    {'_id': 'smesser@rci.rutgers.edu'}
    {'_id': 'kittycobb@hotmail.com'}
    {'_id': 'delkins@interwoven.com'}
    {'_id': 'thdcronm@bol.net.in'}
    {'_id': 'gamble111@yahoo.com'}
    {'_id': 'tori.wells@enron.com'}
    {'_id': 'gregatourhouse@hotmail.com'}
    {'_id': 'scardozo@mindspring.com'}
    {'_id': 'rgolan@spectrumhealth.com'}
    {'_id': 'bbowerfind@yahoo.com'}
    {'_id': 'rondap@earthlink.net'}
    {'_id': 'tomrip1@netscape.net'}
    {'_id': 'jennifer.grotz@prodigy.net'}
    {'_id': 'moxiemorph@animail.net'}
    {'_id': 'lusyd@aol.com'}
    {'_id': 'bvirtue@cogentech.com'}
    {'_id': 'leslie@hgea.org'}
    {'_id': 'garyjamison@earthlink.net'}
    {'_id': 'alexandra@tgharchs.com'}
    {'_id': 'nbarker@libertyhill.org'}
    {'_id': 'patricia.m.hendrix@uth.tmc.edu'}
    {'_id': 'ginger.sinclair@enron.com'}
    {'_id': 'atownley@aol.com'}
    {'_id': 'mark.staff.brandl@switzerland.org'}
    {'_id': 'markcmo@aol.com'}
    {'_id': 'destination2012@aol.com'}
    {'_id': 'counciloftheamericasny@as-coa.org'}
    {'_id': 'w..pereira@enron.com'}
    {'_id': 'mark.harada@enron.com'}
    {'_id': 'jane.gustafson@enron.com'}
    {'_id': 'npembertonjmu@yahoo.com'}
    {'_id': 'cphillabaum@yahoo.com'}
    {'_id': 'maddoglong@hotmail.com'}
    {'_id': 'psionotic@yahoo.com'}
    {'_id': 'kmitchel@coba.usf.edu'}
    {'_id': 'ajones@uwtgc.org'}
    {'_id': 'simone.la@enron.com'}
    {'_id': 'aa5458@wayne.edu'}
    {'_id': 'body.shop@enron.com'}
    {'_id': 'meredith.philipp@enron.com'}
    {'_id': 'wallen@eaglevis.com'}
    {'_id': 'gangitano@bellsouth.net'}
    {'_id': 'hannaz@plmi.com'}
    {'_id': 'david.rollins@enron.com'}
    {'_id': 'jimgeorgie@yahoo.com'}
    {'_id': 'jeff@cclbranding.com'}
    {'_id': 'a..shankman@enron.com'}
    {'_id': 'sostrow@uh.edu'}
    {'_id': 'teacake31@yahoo.com'}
    {'_id': 'jesse@netspend.com'}
    {'_id': 'j.oxer@enron.com'}
    {'_id': 'abbewool@aol.com'}
    {'_id': 'laura@blueworldtravel.com'}
    {'_id': 'jeffrey.westphal@enron.com'}
    {'_id': 'poxford@bracepatt.com'}
    {'_id': 'david.sir.walker@msdw.com'}
    {'_id': 'lucie@jhmedia.com'}
    {'_id': 'livingfree1@hotmail.com'}
    {'_id': 'lmilowe@scmc.org'}
    {'_id': 'swablett@yahoo.com'}
    {'_id': 'brufusd@aol.com'}
    {'_id': 'lizard_ar@yahoo.com'}
    {'_id': 'arader1016@msn.com'}
    {'_id': 'mlynnmel@earthlink.net'}
    {'_id': 'agoldschmidt@earthlink.net'}
    {'_id': 'lcoleygray@sbcglobal.net'}
    {'_id': 'bgriss@yahoo.com'}
    {'_id': 'nick@cavendishwhite.com'}
    {'_id': 'enron.announcement@enron.com'}
    {'_id': 'georgia.fogo@enron.com'}
    {'_id': 'marcierom@yahoo.com'}
    {'_id': 'angelictouch13@hotmail.com'}
    {'_id': 'william_hogan@harvard.edu'}
    {'_id': 'b@msn.com'}
    {'_id': 'jaime.alatorre@enron.com'}
    {'_id': 'davetune@rci.rutgers.edu'}
    {'_id': 'nancy.muchmore@enron.com'}
    {'_id': 'hchayefsky@att.net'}
    {'_id': 'jitendra.agarwal@enron.com'}
    {'_id': 'lunadeinvierno@hotmail.com'}
    {'_id': 'vidalce@hotmail.com'}
    {'_id': 'wieman@cooper.edu'}
    {'_id': 'liesl1@earthlink.net'}
    {'_id': 'veronica.parra@enron.com'}
    {'_id': 'pwarren@rice.edu'}
    {'_id': '110165.74@compuserve.com'}
    {'_id': 'jenniferw@stones.com'}
    {'_id': 'jsporzynski@ica-group.org'}
    {'_id': 'bandersn@loyno.edu'}
    {'_id': 'beau@layfam.com'}
    {'_id': 'thrace_44@yahoo.com'}
    {'_id': 'claynewton@yahoo.com'}
    {'_id': 'rbarnett@handspring.com'}
    {'_id': 'terrance.devereaux@enron.com'}
    {'_id': 'moontiger13@hotmail.com'}
    {'_id': 'a..hughes@enron.com'}
    {'_id': 'customerservice@paragonsports.com'}
    {'_id': 'forrester@forrester.com'}
    {'_id': 'glowest@prodigy.net'}
    {'_id': 'brian.oxley@enron.com'}
    {'_id': 'jtrieglaff@westernseminary.edu'}
    {'_id': 'diane.eckels@enron.com'}
    {'_id': 'lora.sullivan@enron.com'}
    {'_id': 'mothman@tidalwave.net'}
    {'_id': 'jkollaer@houston.org'}
    {'_id': 'yoboliba@yahoo.com'}
    {'_id': 'agallers@yahoo.com'}
    {'_id': 'r..saunders@enron.com'}
    {'_id': 'rinetia.turner@enron.com'}
    {'_id': 'ggalata@enron.co.uk'}
    {'_id': 'joseph.nguyen@enron.com'}
    {'_id': 'adriana.wynn@enron.com'}
    {'_id': 'eorlin@ups.edu'}
    {'_id': 'howard@cohensw.com'}
    {'_id': 'wbd_5@hotmail.com'}
    {'_id': 'kathryn.melton@shell.com'}
    {'_id': 'dakini@bellatlantic.net'}
    {'_id': 'energyinstitute@uh.edu'}
    {'_id': 'walterpye@email.msn.com'}
    {'_id': 'beautyfoul@aol.com'}
    {'_id': 'ronniechan@hanglung.com'}
    {'_id': 'aschilt@pop.uh.edu'}
    {'_id': 'debg@nrel.colostate.edu'}
    {'_id': 'amepya2@hotmail.com'}
    {'_id': 'americassociety@as-coa.org'}
    {'_id': 'bscanlon@smi-online.co.uk'}
    {'_id': 'jpatter@cruzio.com'}
    {'_id': 'amccarty@houston.org'}
    {'_id': 'jperry@tdmn.com'}
    {'_id': 'marge.nadasky@enron.com'}
    {'_id': 'jeanine.denicola@newpower.com'}
    {'_id': 'jim.fallon@enron.com'}
    {'_id': 'thom@raresteeds.com'}
    {'_id': 'jacobsen@swarthmore.edu'}
    {'_id': 'heidimit@color-country.net'}
    {'_id': 'mjlee@netone.com'}
    {'_id': 'connie.blackwood@enron.com'}
    {'_id': 'jimm31@yahoo.com'}
    {'_id': 'lynnewriter@rcn.com'}
    {'_id': 'aachazen@yahoo.com'}
    {'_id': 'carolhuston@yahoo.com'}
    {'_id': 'aceanthony@excite.com'}
    {'_id': 'dbrock@howard.edu'}
    {'_id': 'sarahaway@hotmail.com'}
    {'_id': 'skimforlife@yahoo.com'}
    {'_id': 'olalekan.oladeji@enron.com'}
    {'_id': 'pattyntx2@aol.com'}
    {'_id': 'dickcarl@mediaone.net'}
    {'_id': 'nai@aei.org'}
    {'_id': 'kiwi471@hotmail.com'}
    {'_id': 'mschacht@mail.utexas.edu'}
    {'_id': 'liz.taylor@enron.com'}
    {'_id': 'ktrujill@uwyo.edu'}
    {'_id': 'joec@castlebranch.com'}
    {'_id': 'echota_k23@hotmail.com'}
    {'_id': 'p_berliner@yahoo.com'}
    {'_id': 'jcenter@aei.org'}
    {'_id': 'richard.orellana@enron.com'}
    {'_id': 'steve.kirsch@propel.com'}
    {'_id': '302c5a2f@xmr3.com'}
    {'_id': 'vmartinez@winstead.com'}
    {'_id': 'mharty@lib.siu.edu'}
    {'_id': 'yvonne.jackson@compaq.com'}
    {'_id': 'lpsea@earthlink.net'}
    {'_id': 'email_newsletter@mail.house.gov'}
    {'_id': 'abc226@nyu.edu'}
    {'_id': 'dharder20@hotmail.com'}
    {'_id': 'ctm404@yahoo.com'}
    {'_id': 'robert_healy@msn.com'}
    {'_id': 'donna.muniz@enron.com'}
    {'_id': 'chris@bergenaction.net'}
    {'_id': 'lindaeb@westcoal.org'}
    {'_id': 'enron.announcements@enron.com'}
    {'_id': 'nemtzow@ase.org'}
    {'_id': 'equidans@msn.com'}
    {'_id': 'jwheeler@crstemphousing.com'}
    {'_id': 'david.patton@enron.com'}
    {'_id': 'info@texasgbc.org'}
    {'_id': 'chairman.office@enron.com'}
    {'_id': 'mark.frevert@enron.com'}
    {'_id': 'john.cain@tlc.state.tx.us'}
    {'_id': 'industrial_engr@yahoo.com'}
    {'_id': 'enrique.gimenez@enron.com'}
    {'_id': 'herrold@swbell.net'}
    {'_id': 'justchris63@hotmail.com'}
    {'_id': 'philippe.bibi@enron.com'}
    {'_id': 'amy@kvo.com'}
    {'_id': 'michael.horning@enron.com'}
    {'_id': '.palmer@enron.com'}
    {'_id': 'v.rao@enron.com'}
    {'_id': 'j..anderson@enron.com'}
    {'_id': 'cra123@yahoo.com'}
    {'_id': 'john.ale@enron.com'}
    {'_id': 'mfeaster@sewanee.edu'}
    {'_id': 'dnadel@yahoo.com'}
    {'_id': 'k.justin.luber.3@nd.edu'}
    {'_id': 'sherry.fyman@dpw.com'}
    {'_id': 'suzanne.danz@enron.com'}
    {'_id': 'kbooth@coair.com'}
    {'_id': 'rachelotten@hotmail.com'}
    {'_id': 'olliecat60@hotmail.com'}
    {'_id': 'showy@lycos.com'}
    {'_id': 'sarah.novosel@enron.com'}
    {'_id': 'vanessa.groscrand@enron.com'}
    {'_id': 'joe.hillings@enron.com'}
    {'_id': 'fficiencynews@crest.org'}
    {'_id': 'w..delainey@enron.com'}
    {'_id': 'jidoyle@hotmail.com'}
    {'_id': 'ricex@swbell.net'}
    {'_id': 'cbeichenberger@undata.com'}
    {'_id': 'hstephens@nyc.rr.com'}
    {'_id': 'sgrisham@earthlink.net'}
    {'_id': 'georgia.matula@enron.com'}
    {'_id': 'cynthia.sandherr@enron.com'}
    {'_id': 'ipayit@enron.com'}
    {'_id': 'lynnmg@earthlink.net'}
    {'_id': 'grasmeyer@aerovironment.com'}
    {'_id': 'bgodthing@aol.com'}
    {'_id': 'sferris@olemiss.edu'}
    {'_id': 'petes@sonicfoundry.com'}
    {'_id': 'jcitrolo@aol.com'}
    {'_id': 'hhughes@fpmsi.com'}
    {'_id': 'laffertys@exponentialec.com'}
    {'_id': 'linda.robertson@enron.com'}
    {'_id': 'pablo.acevedo@arnet.com.ar'}
    {'_id': 'charlswalk@aol.com'}
    {'_id': 'illumen@aol.com'}
    {'_id': 'sjhoil@earthlink.com'}
    {'_id': 'generalinfo@marketing.vignette.com'}
    {'_id': 'diana.peters@enron.com'}
    {'_id': 'andrew.wu@enron.com'}
    {'_id': 'walterpye@msn.com'}
    {'_id': 'tj.butler@enron.com'}
    {'_id': 'mary@esisf.com'}
    {'_id': 'lauraammon@linkline.com'}
    {'_id': 'christie.patrick@enron.com'}
    {'_id': 'reslc@aol.com'}
    {'_id': 'dan41867@attbi.com'}
    {'_id': 'dfugate@sandomenico.org'}
    {'_id': 'rebecca.goodman@aya.yale.edu'}
    {'_id': 'beauhan@worldnet.att.net'}
    {'_id': 'stephaniep@mymailstation.com'}
    {'_id': 'jpjfrench@hotmail.com'}
    {'_id': 'sarasandy@aol.com'}
    {'_id': 'jen@drak.net'}
    {'_id': 'exenron@hotmail.com'}
    {'_id': 'ehvaughan@vnsm.com'}
    {'_id': 'josephstanislaw@cera.com'}
    {'_id': 'billy.lemmons@enron.com'}
    {'_id': 'lpowers@techforall.org'}
    {'_id': 'gsattler@geosociety.org'}
    {'_id': 'richard.shapiro@enron.com'}
    {'_id': 'kcg@implementation.com'}
    {'_id': 'huliasz@cwnet.com'}
    {'_id': 'amanda.day@enron.com'}
    {'_id': 'sanwi@webtv.net'}
    {'_id': 'kitty@salk.edu'}
    {'_id': 'ksalinas@houston.org'}
    {'_id': 'lsharp@dreamscape.com'}
    {'_id': 'dfoyo@bellsouth.net'}
    {'_id': 'gilc@usmcoc.org'}
    {'_id': 'paul.v.tebo@usa.dupont.com'}
    {'_id': 'sonjamatanovic@hotmail.com'}
    {'_id': 'jtwolfe@uh.edu'}
    {'_id': 'michelle@firstconf.com'}
    {'_id': 'sabina@msn.com'}
    {'_id': 'fred.philipson@enron.com'}
    {'_id': 'p..dupre@enron.com'}
    {'_id': 'lianne.cairns@enron.com'}
    {'_id': 'justin.rostant@enron.com'}
    {'_id': 'msanjuan@houston.org'}
    {'_id': 'vze27dja@verizon.net'}
    {'_id': 'dzinn@werple.net.au'}
    {'_id': 'bertoady@hotmail.com'}
    {'_id': 'hswygert@howard.edu'}
    {'_id': 'sflick@frickart.org'}
    {'_id': 'justinsitzman@hotmail.com'}
    {'_id': 'rtbrain@mindspring.com'}
    {'_id': 'kseifert@kcc.com'}
    {'_id': 'conway@juggling.org'}
    {'_id': 'jenpresby@yahoo.com'}
    {'_id': 'lingar98@hotmail.com'}
    {'_id': 'kpempek@wdico.com'}
    {'_id': 'j2468@webtv.net'}
    {'_id': 'jongaeyu@hotmail.com'}
    {'_id': 'kdrouet@molecularelectronics.com'}
    {'_id': 'dberg13046@aol.com'}
    {'_id': 'judy.knepshield@enron.com'}
    {'_id': 'vincent@cynetinc.com'}
    {'_id': 'gayla.seiter@enron.com'}
    {'_id': 'lbdcon@hotmail.com'}
    {'_id': 'carolines@learningstrategies.com'}
    {'_id': 'refertofriend@reply.yahoo.com'}
    {'_id': 'christian@ncgia.ucsb.edu'}
    {'_id': 'kunklerb@msx.upmc.edu'}
    {'_id': 'm_noland@yahoo.com'}
    {'_id': 'roesler@empslc.com'}
    {'_id': 'ereames@capu.net'}
    {'_id': 'maggie@nlstudio.com'}
    {'_id': 'nancy.damico@nettest.com'}
    {'_id': 'bennettw@mindspring.com'}
    {'_id': 'rstephe@sun.science.wayne.edu'}
    {'_id': 'lshanlon@yahoo.com'}
    {'_id': 'prod1@earthlink.net'}
    {'_id': 'magnunc1@jhuapl.edu'}
    {'_id': 'appelled@apci.com'}
    {'_id': 'congressman.sessions@mail.house.gov'}
    {'_id': 'kinoidiot@hotmail.com'}
    {'_id': 'marya2000@yahoo.com'}
    {'_id': 'jimemerson@hotmail.com'}
    {'_id': 'rjonak@hotmail.com'}
    {'_id': 'resta@u.washington.edu'}
    {'_id': 'lvnalencz@yahoo.com'}
    {'_id': 'crumpet@indy.net'}
    {'_id': 'delia.walters@enron.com'}
    {'_id': 'a..lindholm@enron.com'}
    {'_id': 'stacy.guidroz@enron.com'}
    {'_id': 'arta@houston.rr.com'}
    {'_id': 'neal@enron.com'}
    {'_id': 'london.brown@enron.com'}
    {'_id': 'hmlangetx@aol.com'}
    {'_id': 'linda@latreo.net'}
    {'_id': 'eigcirculation@networkats.com'}
    {'_id': 'jtnunemaker@yahoo.com'}
    {'_id': 'stephen.perich@enron.com'}
    {'_id': 'jemer4@home.com'}
    {'_id': 'lallimj@yahoo.com'}
    {'_id': 'tricia.schultz@gaiam.com'}
    {'_id': 'suketu.patel@enron.com'}
    {'_id': 'robert.anthony@brookwoods.com'}
    {'_id': 'ehkeditor@hongkong.org'}
    {'_id': 'admin@fsddatasvc.com'}
    {'_id': 'ecohan@rei.com'}
    {'_id': 'katrinatoshik@hotmail.com'}
    {'_id': 'loretta.brelsford@enron.com'}
    {'_id': 'angel2@txucom.net'}
    {'_id': 'robyn@layfam.com'}
    {'_id': 'nleaper@sisna.com'}
    {'_id': 'mgiese@pcbackup.cc'}
    {'_id': 'gapres@webtv.net'}
    {'_id': 'barblpl@yahoo.com'}
    {'_id': 'rightworks@rightworks.rsvp0.net'}
    {'_id': 'kmewig@yahoo.com'}
    {'_id': 'anita_anthony@ziffdavis.com'}
    {'_id': 'linda.faircloth@enron.com'}
    {'_id': 'mary.shelton@ncmail.net'}
    {'_id': 'muncheysmom@netscape.net'}
    {'_id': 'sabrams@paragonsports.com'}
    {'_id': 'jackie.henry@enron.com'}
    {'_id': 'soulkaren@hotmail.com'}
    {'_id': 'carlab@pacbell.net'}
    {'_id': 'james.derrick@enron.com'}
    {'_id': 'jdybell@houston.org'}
    {'_id': 'dewey@deweyballantine.com'}
    {'_id': 'dianef@houston.rr.com'}
    {'_id': 'ksherwood@uschamber.com'}
    {'_id': 'jbarry@eyeforenergy.com'}
    {'_id': 'bibayoff@winfirst.com'}
    {'_id': 'jgsidak@aei.org'}
    {'_id': 'karen.denne@enron.com'}
    {'_id': 'dnagle@meshbesher.com'}
    {'_id': 'magda.manigque@kp.org'}
    {'_id': 'dlaws@houston.rr.com'}
    {'_id': 'kmschutte@hotmail.com'}
    {'_id': 'announcements.enron@enron.com'}
    {'_id': 'vbryant@aei.org'}
    {'_id': 'noel.ryan@enron.com'}
    {'_id': 'kcmanatee@yahoo.com'}
    {'_id': 'sharon@iwearart.com'}
    {'_id': 'lpomplas@gc.cuny.edu'}
    {'_id': 'ken.roman@verizon.net'}
    {'_id': 'communications.newpower@enron.com'}
    {'_id': 'lgill@wafs.com'}
    {'_id': 'scott.cook@excellus.com'}
    {'_id': 'susanabyers@nyc.rr.com'}
    {'_id': 'rod@canion.com'}
    {'_id': 'addyee@aol.com'}
    {'_id': 'kann@pdq.net'}
    {'_id': 'cstamm@sekani.com'}
    {'_id': 'ryan.seleznov@enron.com'}
    {'_id': 'lkhohmann@yahoo.com'}
    {'_id': 'jdbirdwhistell@yahoo.com'}
    {'_id': 'guerrero@aig.com'}
    {'_id': 'ccox@businesscouncil.com'}
    {'_id': 'arthur.ransome@enron.com'}
    {'_id': 'pakrueger@earthlink.net'}
    {'_id': 'jmoncada@fftw.com'}
    {'_id': 'denisea38@yahoo.com'}
    {'_id': 'dougancil1@hotmail.com'}
    {'_id': 'thomas.moore@enron.com'}
    {'_id': 'marl552@aol.com'}
    {'_id': 'olympianmk@al.com'}
    {'_id': 'janetteathome@animail.net'}
    {'_id': 'jashford@jashford.com'}
    {'_id': 'jim.schwieger@enron.com'}
    {'_id': 'jeff.mcclellan@enron.com'}
    {'_id': 'hddanz@yahoo.com'}
    {'_id': 'bmargolas@hotmail.com'}
    {'_id': 'rpon@bellatlantic.net'}
    {'_id': 'elizabeth.mazzetti@openwave.com'}
    {'_id': 'julie_freedman@student.hms.harvard.edu'}
    {'_id': 'knightrider2008@yahoo.com'}
    {'_id': 'mlcarswel@aol.com'}
    {'_id': 'mike.mcconnell@enron.com'}
    {'_id': 'lisa.hobbs@enron.com'}
    {'_id': 'gary.choquette@enron.com'}
    {'_id': 'im1timescape@netscape.net'}
    {'_id': 'fitzsimmonsp@sbcglobal.net'}
    {'_id': 'info@enron.com'}
    {'_id': 'jean_macrobbie@berlex.com'}
    {'_id': 'lweiss@instantlivetalk.com'}
    {'_id': 'swilliam@centramedia.net'}
    {'_id': 'jimc45@aol.com'}
    {'_id': 'ofra.mor@themarker.com'}
    {'_id': 'reservations@coronadoclub.com'}
    {'_id': 'mary.brown@pwblf.org'}
    {'_id': 'cheryltd@tbardranch.com'}
    {'_id': 'fmwhit@sover.net'}
    {'_id': 'kkosman@aei.org'}
    {'_id': 'nhernandez@cera.com'}
    {'_id': 'cwhitcomb@worldnet.att.net'}
    {'_id': 'susanvancil@excite.com'}
    {'_id': 'maurypolk@mindspring.com'}
    {'_id': 'halperin@rff.org'}
    {'_id': 'kfrankso@jhmi.edu'}
    {'_id': 'acej42@aol.com'}
    {'_id': 'kristenmansure@economist.com'}
    {'_id': 'jennifer@freshwater.com'}
    {'_id': 'bwhitney@eb.com'}
    {'_id': 'taria.reed@enron.com'}
    {'_id': 'kirazoe@msn.com'}
    {'_id': 'jea.kenney@prudential.com'}
    {'_id': 'ruthharris1@aol.com'}
    {'_id': 'terence.thorn@enron.com'}
    {'_id': 'bokra2@mindspring.com'}
    {'_id': 'jdbok@mindspring.com'}
    {'_id': 'darlene_grossman@hmco.com'}
    {'_id': 'craig.buehler@enron.com'}
    {'_id': 'events@equityinternational.tv'}
    {'_id': 'mailadmin@independent.org'}
    {'_id': 'lisa_clifford@i2.com'}
    {'_id': 'bestbrooke@mindspring.com'}
    {'_id': 'amy.lee@enron.com'}
    {'_id': 'morrisjhd@aol.com'}
    {'_id': 'mcox@nam.org'}
    {'_id': 'lynda.l.phinney@williams.com'}
    {'_id': 'vincer@publicans.com'}
    {'_id': 'info@conceptdesigninc.com'}
    {'_id': 'hreasoner@velaw.com'}
    {'_id': 'theglobalist@theglobalist.com'}
    {'_id': 'rdaugbjerg@aol.com'}
    {'_id': 'bridget.williams@enron.com'}
    {'_id': 'krdicker@aol.com'}
    {'_id': 'kathryn.corbally@enron.com'}
    {'_id': 'stelzer@aol.com'}
    {'_id': 'kittyspaz@yahoo.com'}
    {'_id': 'cowan@howard.edu'}
    {'_id': 'markrobertsny@earthlink.net'}
    {'_id': 'eyeball41@aol.com'}
    {'_id': 'rosmond@hnw.com'}
    {'_id': 'michelle.foust@enron.com'}
    {'_id': 'xiaowu.huang@enron.com'}
    {'_id': 'joseph.sutton@enron.com'}
    {'_id': 'mgh9999@aol.com'}
    {'_id': 'msmlbaker@hotmail.com'}
    {'_id': 'benjamin.rogers@enron.com'}
    {'_id': 'hallgrau@earthlink.net'}
    {'_id': 'kdrouet@iexalt.net'}
    {'_id': 'agaur@tjbc.coj'}
    {'_id': 'snapshotro@aol.com'}
    {'_id': 'david.tagliarino@enron.com'}
    {'_id': 'korbeck@rdblaw.com'}
    {'_id': 'mspartalis@mlrpc.com'}
    {'_id': 'brent.vasconcellos@enron.com'}
    {'_id': 'jessica@lplpi.com'}
    {'_id': 'jredwine@yahoo.com'}
    {'_id': 'chad.corbitt@enron.com'}
    {'_id': 'm..gasdia@enron.com'}
    {'_id': 'summyto@hotmail.com'}
    {'_id': 'mick.seidl@moore.org'}
    {'_id': 'ysabe@alum.calberkeley.org'}
    {'_id': 'pdouglas@salus.net'}
    {'_id': 'araemurphy@hotmail.com'}
    {'_id': 'debgebhardt@hotmail.com'}
    {'_id': 'jimrod63@aol.com'}
    {'_id': 'drsukie@yahoo.com'}
    {'_id': 'kelly@erienet.net'}
    {'_id': 'adnan.patel@enron.com'}
    {'_id': 'tarah@arches.uga.edu'}
    {'_id': 'gentjobs@yahoo.com'}
    {'_id': 'carole.cleary@msdw.com'}
    {'_id': 'smith@enron.com'}
    {'_id': 'ali@panix.com'}
    {'_id': 'guido.govers@enron.com'}
    {'_id': 'julia@sorensen-jolink-trubo.com'}
    {'_id': 'kerjordan@yahoo.com'}
    {'_id': 'peter.weidler@enron.com'}
    {'_id': 'katiedidmoore@yahoo.com'}
    {'_id': 'theodore.a.schwab@rssmb.com'}
    {'_id': 'fsteiger@ceoamerica.org'}
    {'_id': 'hattie.carrington@enron.com'}
    {'_id': 'nstahl@bowdoin.edu'}
    {'_id': 'annette.ambriz@compaq.com'}
    {'_id': 'grace.corbin@christnerinc.com'}
    {'_id': 'cordia@cordia.com'}
    {'_id': 'jon.katzenbach@katzenbach.com'}
    {'_id': 'margaret@motelmag.com'}
    {'_id': 'conference@milkeninstitute.org'}
    {'_id': 'jpolly@sfaf.org'}
    {'_id': 'dpm630@mizzou.edu'}
    {'_id': 'robert.johnston@enron.com'}
    {'_id': 'btzcat@webtv.net'}
    {'_id': 'ext.443@kor-seek.com'}
    {'_id': 'juanacastanha@aol.com'}
    {'_id': 'richardnolan@smipublishing.co.uk'}
    {'_id': 'barbara.paige@enron.com'}
    {'_id': 'bengelhart@pantechnica.com'}
    {'_id': 'richarde@centurydev.com'}
    {'_id': 'sanjiv_sidhu@i2.com'}
    {'_id': 'sheila.jones@enron.com'}
    {'_id': 'ghamel@strategos.com'}
    {'_id': 'rebs1973@yahoo.com'}
    {'_id': 'sbarrick@questia.com'}
    {'_id': 'state_of_the_world_forum@stateoftheworldforum.r-3.net'}
    {'_id': 'collectivedesigns@mediaone.net'}
    {'_id': 'smanzon@flashfind.com'}
    {'_id': 'ellen.fowler@enron.com'}
    {'_id': 'imprintagency@earthlink.net'}
    {'_id': 'mattmcc@traverse.com'}
    {'_id': 'chia@ayup.limey.net'}
    {'_id': 'kwol84@hotmail.com'}
    {'_id': 'virginia.cavazos@enron.com'}
    {'_id': 'kathy.mayfield@enron.com'}
    {'_id': 'enronsato@hotmail.com'}
    {'_id': 'deadmandrj@aol.com'}
    {'_id': 'baumank@yahoo.com'}
    {'_id': 'johnnie.nelson@enron.com'}
    {'_id': 'jeremymcbryan@netscape.net'}
    {'_id': 'mdpeterson@siriusimages.com'}
    {'_id': 'cindy.stark@enron.com'}
    {'_id': 'comet@starshaper.com'}
    {'_id': 'jwatson@velaw.com'}
    {'_id': 'maria.barnet@myhomekey.com'}
    {'_id': 'bonnie.allen@enron.com'}
    {'_id': 'pgun100@yahoo.com'}
    {'_id': 'ktrue@centruytel.net'}
    {'_id': 'adminsec@centralhouston.org'}
    {'_id': 'anastasia@omegamoulding.com'}
    {'_id': 'celb60@aol.com'}
    {'_id': 'rajesh.sarkar@mphasis.com'}
    {'_id': 'karen55@earthlink.net'}
    {'_id': 'bournebj@aol.com'}
    {'_id': 'baaramyoo@yahoo.com'}
    {'_id': 'baldtimwin@hotmail.com'}
    {'_id': 'danhyde@mindspring.com'}
    {'_id': 'marcus@arts.usf.edu'}
    {'_id': 'andrew.parsons@enron.com'}
    {'_id': 'michael.capellas@compaq.com'}
    {'_id': 'shari.thompson@enron.com'}
    {'_id': 'mark.lay@enron.com'}
    {'_id': 'watch@csis.org'}
    {'_id': 'doctorbonner@altavista.com'}
    {'_id': 'joseph.pestana@enron.com'}
    {'_id': 'matagasco@aol.com'}
    {'_id': 'pway@wayholding.com'}
    {'_id': 'hhabicht@getf.org'}
    {'_id': 'sunil.misser@us.pwcglobal.com'}
    {'_id': 'cae8304@mail.paccd.cc.ca.us'}
    {'_id': 'kcschock@aol.com'}
    {'_id': 'homunculus_2001@yahoo.com'}
    {'_id': 'smroyce@yahoo.com'}
    {'_id': 'maokotani@aol.com'}
    {'_id': 'diego_baz@worldnet.att.net'}
    {'_id': 'donnis.traylor@enron.com'}
    {'_id': 'judy.e.collazo@ssmb.com'}
    {'_id': 'doug.leach@enron.com'}
    {'_id': 'sangelo@fsaelgin.org'}
    {'_id': 'scott.vonderheide@enron.com'}
    {'_id': 'mattstreit@hotmail.com'}
    {'_id': 'sean@witheveryidlehour.com'}
    {'_id': 'mark.brand@enron.com'}
    {'_id': 'djah1@yahoo.com'}
    {'_id': 'william.ramsay@iea.org'}
    {'_id': 'kathi.morrissey@compaq.com'}
    {'_id': 'kelly.merritt@enron.com'}
    {'_id': 'esummers@digitas.com'}
    {'_id': 'amita.gosalia@enron.com'}
    {'_id': 'rich7306@aol.com'}
    {'_id': 'leo3@linbeck.com'}
    {'_id': 'inanyevent@worldnet.att.net'}
    {'_id': 'update@aei.org'}
    {'_id': 'rbbesco@aol.com'}
    {'_id': 'vaughn@plu.edu'}
    {'_id': 'goodpooch@hotmail.com'}
    {'_id': 'no.address@enron.com'}
    {'_id': 'mjensen@nas.edu'}
    {'_id': 'meta4@frontiernet.net'}
    {'_id': 'kc.5076015.170.0@reply.iwov.com'}
    {'_id': 'sbmccollum_99@yahoo.com'}
    {'_id': 'winifred.isaac@enron.com'}
    {'_id': 'andrea_lueders@hotmail.com'}
    {'_id': 'laine.powell@enron.com'}
    {'_id': 'betty.alexander@enron.com'}
    {'_id': 'jivens@mhaglobal.com'}
    {'_id': 'cherylf@autodesk.com'}
    {'_id': 'smaynes@globalcrossing.com'}
    {'_id': 'avanleunen@msn.com'}
    {'_id': 'jparker@dentsply.com'}
    {'_id': 'dkwylie@ilstu.edu'}
    {'_id': 'sbrandt@crc-evans.com'}
    {'_id': 'mortimer.bravo@blueyonder.co.uk'}
    {'_id': 'paul.murray@enron.com'}
    {'_id': 'debbie.foot@enron.com'}
    {'_id': 'smarianne1@juno.com'}
    {'_id': 'leo_jr@linbeck.com'}
    {'_id': 'wade.cline@enron.com'}
    {'_id': 'nicki.daw@enron.com'}
    {'_id': 'george.palmer@bc.istonish.com'}
    {'_id': 'sally.kirch@intel.com'}
    {'_id': 'kevin.garland@enron.com'}
    {'_id': 'mwhelan@csis.org'}
    {'_id': 'legsalad@hotmail.com'}
    {'_id': 'alyssa300@hotmail.com'}
    {'_id': 'j@seanet.com'}
    {'_id': 'ra_crutchfield@yahoo.com'}
    {'_id': 'knowak@wpo.org'}
    {'_id': 'nshabat@post.harvard.edu'}
    {'_id': 'cturcich@houston.rr.com'}
    {'_id': 'specialgstorakle@aol.com'}
    {'_id': 'rbriden@ballou.com'}
    {'_id': 'will.reed@techforall.org'}
    {'_id': 'c12cshift@yahoo.com'}
    {'_id': 'frank.acuff@enron.com'}
    {'_id': 'dan.leff@enron.com'}
    {'_id': 'aharpaz@doverinstrument.com'}
    {'_id': 'marie.mcduff@compaq.com'}
    {'_id': 'op25no1@hotmail.com'}
    {'_id': 'dori_merifield@yahoo.com'}
    {'_id': 'tgroup@compaq.com'}
    {'_id': 'sophie.patel@enron.com'}
    {'_id': 'info@rlcnet.org'}
    {'_id': 'harlos@jove.acs.unt.edu'}
    {'_id': 'sokalkyle@hotmail.com'}
    {'_id': 'gorelick@marthastewart.com'}
    {'_id': 'jim.roth@enron.com'}
    {'_id': 'brenda.j.carroll@verizon.com'}
    {'_id': 'kenneth.lay@enron.com'}
    {'_id': 'dlarson@nwhealth.edu'}
    {'_id': 'marcias@concorde-newhorizons.com'}
    {'_id': 'erincday@aol.com'}
    {'_id': 'robert.keylock@enron.com'}
    {'_id': 'monte4amy@juno.com'}
    {'_id': 'davidtaylorsf@aol.com'}
    {'_id': 'emma2100@mediaone.net'}
    {'_id': 'cg1146@yahoo.com'}
    {'_id': 'phubbard@boulderwest.com'}
    {'_id': 'tung@unc.edu'}
    {'_id': 'lrenaud@bellatlantic.net'}
    {'_id': 'ellie.elphick@sdsheriff.org'}
    {'_id': 'contact@weforum.org'}
    {'_id': 'sbracken@hsc.utah.edu'}
    {'_id': 'hmlight@aol.com'}
    {'_id': 'kulkite@aol.com'}
    {'_id': 'jtoland@forrester.com'}
    {'_id': 'pravas@ruf.rice.edu'}
    {'_id': 'h..boots@enron.com'}
    {'_id': 'cynthia.x.rutherford@kp.org'}
    {'_id': 'jf23@columbia.edu'}
    {'_id': 'salzate@houston.org'}
    {'_id': 'joanna@groupdesigninc.com'}
    {'_id': 'maureen.sampson@enron.com'}
    {'_id': 'valerie.petersen@yale.edu'}
    {'_id': 'jpickard@softrax.com'}
    {'_id': 'jdoerr@kpcb.com'}
    {'_id': 'kmpeabody@mediaone.net'}
    {'_id': 'paul@psd7.com'}
    {'_id': 'auburnandel@yahoo.com'}
    {'_id': 'kathy.ringblom@enron.com'}
    {'_id': 'mailings@cnn.com'}
    {'_id': 'jdatt@bender.com'}
    {'_id': 'katherine.brown@enron.com'}
    {'_id': 'coates@gilanet.com'}
    {'_id': 'lesliemr@pacbell.net'}
    {'_id': 'rmellen@san.rr.com'}
    {'_id': 'andrew.henderson@enron.com'}
    {'_id': 'susan.poole@enron.com'}
    {'_id': 'petegohm@aol.com'}
    {'_id': 'laura.valencia@enron.com'}
    {'_id': 'kkwright@texaschildrenshospital.org'}
    {'_id': 'mccann@nc.rr.com'}
    {'_id': 'pam.benson@enron.com'}
    {'_id': 'laurel.crafts@library.gatech.edu'}
    {'_id': 'tarn@selway.umt.edu'}
    {'_id': 'sarah_rimer@hotmail.com'}
    {'_id': 'sbutler@nutrastar.com'}
    {'_id': 'joe@fpud.com'}
    {'_id': 'tcssunsurvey@burke.com'}
    {'_id': 'mhk@heinzctr.org'}
    {'_id': 'moore2311@aol.com'}
    {'_id': 'lyndaw@mediaweavers.com'}
    {'_id': 'production@gatepoint.net'}
    {'_id': 'richroge@attbi.com'}
    {'_id': 'ahimsaom@cs.com'}
    {'_id': 'sleemak@aol.com'}
    {'_id': 'wesley.kendall@lexis-nexis.com'}
    {'_id': 'cozzolino615@yahoo.com'}
    {'_id': 'sherry.butler@enron.com'}
    {'_id': 'bradgood@magix.com.sg'}
    {'_id': 'rosalee.fleming@enron.com'}
    {'_id': 'essentialhealth@webtv.net'}
    {'_id': 'davidcabello@earthlink.net'}
    {'_id': 'wild@sfo.com'}
    {'_id': 'jonathan@just-works.com'}
    {'_id': 'np@niceshoes.com'}
    {'_id': 'friesen@uiowa.edu'}
    {'_id': 'thomas.kalb@enron.com'}
    {'_id': 'automatedmail@mplanners.com'}
    {'_id': 'earlene.ackley@enron.com'}
    {'_id': 'jmcsimov@netscape.net'}
    {'_id': 'balker@warrenelectric.com'}
    {'_id': 'freimer.1@osu.edu'}
    {'_id': 'marie.newhouse@enron.com'}
    {'_id': 'kgh1021@yahoo.com'}
    {'_id': 'ichak.adizes@managementvitality.com'}
    {'_id': 'bcsnare@yahoo.com'}
    {'_id': 'everan01@hotmail.com'}
    {'_id': 'knowledgeman1300@hotmail.com'}
    {'_id': 'cmisseldine@mindspring.com'}
    {'_id': 'cactusaz@hotmail.com'}
    {'_id': 'raebevis@hotmail.com'}
    {'_id': 'toddbart@aol.com'}
    {'_id': 'robert.jones@mailman.enron.com'}
    {'_id': 'boggs@newbasics.com'}
    {'_id': 'lenalalita@hotmail.com'}
    {'_id': 'elizabeth.linnell@enron.com'}
    {'_id': 'mragsdal@aol.com'}
    {'_id': 'dale@newfield.org'}
    {'_id': 'lane@fastlanestudios.com'}
    {'_id': 'coachnate@aol.com'}
    {'_id': 'elizabeth.tilney@enron.com'}
    {'_id': 'sanjaybhatnagar00@yahoo.com'}
    {'_id': 'larry.izzo@enron.com'}
    {'_id': 'lizzard@austin.rr.com'}
    {'_id': 'mary.clark@enron.com'}
    {'_id': 'em418@hotmail.com'}
    {'_id': 'john.lavorato@enron.com'}
    {'_id': 'shelly@sswlaw.com'}
    {'_id': 'jvuich@pacbell.net'}
    {'_id': 'courtney.hanson@ourclub.com'}
    {'_id': '2krayz@gte.net'}
    {'_id': 'clara.carrington@enron.com'}
    {'_id': 'bryan.seyfried@enron.com'}
    {'_id': 'lee.papayoti@enron.com'}
    {'_id': 'jwalsh@brooklynx.org'}
    {'_id': 'lyngla@earthlink.net'}
    {'_id': 'skinnerj@central.edu'}
    {'_id': 'rltmmb@earthlink.net'}
    {'_id': 'danielyergin@cera.com'}
    {'_id': 'usameeting@weforum.org'}
    {'_id': 'ashton@mjmcreative.com'}
    {'_id': 'rodney.derbigny@enron.com'}
    {'_id': 'aagigian@suffolk.edu'}
    {'_id': 'brian.terp@enron.com'}
    {'_id': 'governing@aei.org'}
    {'_id': 'muaa@mizzou.com'}
    {'_id': 'sleepingdog@mn.rr.com'}
    {'_id': 'lucy.king@enron.com'}
    {'_id': 'joannie.williamson@enron.com'}
    {'_id': 'michelle.hargrave@enron.com'}
    {'_id': 'silvano.coletti@ecosquare.com'}
    {'_id': 'terryh@email.uky.edu'}
    {'_id': 'gharleyb@aol.com'}
    {'_id': 'wefinvitation@forbes.com'}
    {'_id': 'jennifer.richard@enron.com'}
    {'_id': 'skaczenski@velaw.com'}
    {'_id': 'arebil@webtv.net'}
    {'_id': 'ghostsarehere@webtv.net'}
    {'_id': 'cmonahan_99@yahoo.com'}
    {'_id': 'douglas.huth@enron.com'}
    {'_id': 'bhederman@icfconsulting.com'}
    {'_id': 'erinerinb@yahoo.com'}
    {'_id': 'cedric.burgher@enron.com'}
    {'_id': 'susan.holland@mercermc.com'}
    {'_id': 'arthur.goldsmith@enron.com'}
    {'_id': 'kerry.donk@esca.com'}
    {'_id': 'helckat@aol.com'}
    {'_id': 'nshapiro@ifc.org'}
    {'_id': 'scott.beilharz@gehh.ge.com'}
    {'_id': 'bodyshop@enron.com'}
    {'_id': 'scott_a_edmonson@amat.com'}
    {'_id': 'dananddeb@novagate.com'}
    {'_id': 'scenicmo@tranquility.net'}
    {'_id': 'elizabeth.jewell@villanova.edu'}
    {'_id': 'tim.bailey@adidasus.com'}
    {'_id': 'ameliapower@hotmail.com'}
    {'_id': 'elduque@austin.rr.com'}
    {'_id': 'myheartmusic@yahoo.com'}
    {'_id': 'norma.masek@unisys.com'}
    {'_id': 'hanesds@iname.com'}
    {'_id': 'c.spalding@montmech.com'}
    {'_id': 'cashflowebusiness@aol.com'}
    {'_id': 'jdmnash@home.com'}
    {'_id': 'stacy.walker@enron.com'}
    {'_id': 'godswork@mail.com'}
    {'_id': 'cbt@medicine.wisc.edu'}
    {'_id': 'nolesjames@aol.com'}
    {'_id': 'alberto_jaramillo@putnaminv.com'}
    {'_id': 'mamuska@san.rr.com'}
    {'_id': 'shuebox@u.washington.edu'}
    {'_id': 'raymond.bowen@enron.com'}
    {'_id': 'mpaulina@kantola.com'}
    {'_id': 'mossmom@cybermesa.com'}
    {'_id': 'scott.affelt@enron.com'}
    {'_id': 'mattd51@juno.com'}
    {'_id': 'chairman.enron@enron.com'}
    {'_id': 'jensleb1@yahoo.com'}
    {'_id': 'asnyirenda@zesco.co.zm'}
    {'_id': 'devine@ssprd2.net'}
    {'_id': 'rick.buy@enron.com'}
    {'_id': 'bille@cnt.org'}
    {'_id': 'lrissover@hotmail.com'}
    {'_id': 'neldashealy@yahoo.com'}
    {'_id': 'ann.lofton@compassbnk.com'}
    {'_id': 'esheridan@uh.edu'}
    {'_id': 'smsdav@earthlink.net'}
    {'_id': 'candlman@pacbell.net'}
    {'_id': 'bslvn@hotmail.com'}
    {'_id': 'mack@orci.com'}
    {'_id': 'info@analytic-solutions.com'}
    {'_id': 'scott.foulk@spirentcom.com'}
    {'_id': 'mschopper@houston.org'}
    {'_id': 'meg_daniel@yahoo.com'}
    {'_id': 'tdowe@houston.org'}
    {'_id': 'gihoff@pacbell.net'}
    {'_id': 'teri@igc.org'}
    {'_id': 'tamara_wieder@hotmail.com'}
    {'_id': 'kirkwitzberger@hotmail.com'}
    {'_id': 'johnp@energycoalition.org'}
    {'_id': 'arik@e-business-e.com'}
    {'_id': 'iris.mack@enron.com'}
    {'_id': 'jab@wincrest.com'}
    {'_id': 'stlamb@beehive.com'}
    {'_id': 'carolus@optonline.net'}
    {'_id': 'woolverton@aol.com'}
    {'_id': 'erickson.stephen@mayo.edu'}
    {'_id': 'ssusanbalmer@aol.com'}
    {'_id': '.elizondo@enron.com'}
    {'_id': 'lgunnell@msgidirect.com'}
    {'_id': 'gurinder.tamber@enron.com'}
    {'_id': 'cbrooksbank@lineone.net'}
    {'_id': 'rebekah.rushing@enron.com'}
    {'_id': 'kjdevlin@austin.rr.com'}
    {'_id': 'steve.montovano@enron.com'}
    {'_id': 'carlos.vicens@enron.com'}
    {'_id': 'sandra.lighthill@enron.com'}
    {'_id': 'bildel@muze.com'}
    {'_id': 'eric.shaw@enron.com'}
    {'_id': 'mike@way-wired.com'}
    {'_id': 'mikesingh@telus.net'}
    {'_id': 'lametrice.dopson@enron.com'}
    {'_id': 'ealvittor@yahoo.com'}
    {'_id': 'vonrob@speakeasy.net'}
    {'_id': 'vridhay.mathias@enron.com'}
    {'_id': 'rex.shelby@enron.com'}
    {'_id': 'hemmat.safwat@enron.com'}
    {'_id': 'mtbeli@hotmail.com'}
    {'_id': 'sniffejr@yahoo.com'}
    {'_id': 'bereston@flash.net'}
    {'_id': 'eric@om28.com'}
    {'_id': 'rseroussi@buchalter.com'}
    {'_id': 'rengelt@earthlink.net'}
    {'_id': 'rbanzai@yahoo.com'}
    {'_id': 'dheard@austin.rr.com'}
    {'_id': 'gw@alpenimage.com'}
    {'_id': 'anntares@yahoo.com'}
    {'_id': 'snorman@ccc.gerbertechnology.com'}
    {'_id': 'carolemerr@aol.com'}
    {'_id': 'graverj@mail.rfweston.com'}
    {'_id': 'pinetops.stephen@iname.com'}
    {'_id': 'betty.hanchey@enron.com'}
    {'_id': 'katieh@ruf.rice.edu'}
    {'_id': 'everitt_mary_j@lilly.com'}
    {'_id': 'theweblion@hotmail.com'}
    {'_id': 'sethomas@zianet.com'}
    {'_id': 'lblanchard@howard.edu'}
    {'_id': 'miriam.brabham@enron.com'}
    {'_id': 'ltam@ltdnet.com'}
    {'_id': 'beth.levine@ppfa.org'}
    {'_id': 'mark.koenig@enron.com'}
    {'_id': 'cnamprem@cs.ucsd.edu'}
    {'_id': 'patedrp@aol.com'}
    {'_id': 'malmuth@aol.com'}
    {'_id': 'fredshirley@earthlink.net'}
    {'_id': 'jeff.donahue@enron.com'}
    {'_id': 'heath.schiesser@enron.com'}
    {'_id': 'vtament@charter.net'}
    {'_id': 'slx@xcert.com'}
    {'_id': 'robert@kovair.com'}
    {'_id': 'wms@kainon.com'}
    {'_id': 'shelley.johnson@enron.com'}
    {'_id': 'kmchugh@wsgc.com'}
    {'_id': 'ezra@lucidcircus.com'}
    {'_id': 'william.bolster@nbc.com'}
    {'_id': 'billweller@aol.com'}
    {'_id': 'terry.hare@nepco.com'}
    {'_id': 'saima.qadir@enron.com'}
    {'_id': 'sarah.berger@nyu.edu'}
    {'_id': 'lisamarieland@yahoo.com'}
    {'_id': 'llindsay@whidbey.com'}
    {'_id': 'campa@lvcm.com'}
    {'_id': 'msgermann@juno.com'}
    {'_id': 'colson@enron.com'}
    {'_id': 'pholmes@cnw.com'}
    {'_id': 'ralph.blakemore@enron.com'}
    {'_id': 'jeff.shields@enron.com'}
    {'_id': 'jkpais@netscape.net'}
    {'_id': 'rfinfrock@finfrock.cc'}
    {'_id': 'jmcc_tx@msn.com'}
    {'_id': 'bevo@pacbell.net'}
    {'_id': 'coa@attglobal.net'}
    {'_id': 'texas@readynet.net'}
    {'_id': 'kjfalk@womeninit.net'}
    {'_id': 'corrieb@ix.netcom.com'}
    {'_id': 'rick.hare@williams.com'}
    {'_id': 'agatha.tran@enron.com'}
    {'_id': 'meredyth88@aol.com'}
    {'_id': 'ruth.brown@enron.com'}
    {'_id': 'michaelmiller@mac.com'}
    {'_id': 'steve@stevesvet.com'}
    {'_id': 'slade_pd@tsu.edu'}
    {'_id': 'krisna_becker@hgsi.com'}
    {'_id': 'lfan@mailman.enron.com'}
    {'_id': 'newsletter@integralaccess.com'}
    {'_id': 'rdavis@powerlight.com'}
    {'_id': 'greg.lewis@enron.com'}
    {'_id': 'antoinette.beale@enron.com'}
    {'_id': 'scotth1965@hotmail.com'}
    {'_id': 'chrystallynnboyle@hotmail.com'}
    {'_id': 'nreid@tycoint.com'}
    {'_id': 'david@columbia.org'}
    {'_id': 'eugenegarver_marangoni@yahoo.com'}
    {'_id': 'annemwang@excite.com'}
    {'_id': 'shanspice@yahoo.com'}
    {'_id': 'ecaperton@mindspring.com'}
    {'_id': 'andrew.fastow@enron.com'}
    {'_id': 'aosawa@attglobal.net'}
    {'_id': 'bbreen@questia.com'}
    {'_id': 'lnewnam@lacdc.org'}
    {'_id': 'dcrofts@hotmail.com'}
    {'_id': 'garry.mcdaniel@amd.com'}
    {'_id': 'sally.beck@enron.com'}
    {'_id': 'ldavis@bcpl.net'}
    {'_id': 'keenbruin@yahoo.com'}
    {'_id': 'actforchange.com@mailman.enron.com'}
    {'_id': 'vidal@martinez.net'}
    {'_id': 'mlangdell@aol.com'}
    {'_id': 'jjgrodi@ameritech.net'}
    {'_id': 'fraisy.george@enron.com'}
    {'_id': 'jwinstonk@yahoo.com'}
    {'_id': 'pacondit@hotmail.com'}
    {'_id': 'lyow@indiana.edu'}
    {'_id': 'siukkuk@aol.com'}
    {'_id': 'ryecatcher64@hotmail.com'}
    {'_id': 'tfolse@lsu.edu'}
    {'_id': 'alexis415@yahoo.com'}
    {'_id': 'tscott@chadbourne.com'}
    {'_id': 'beau@rrhinvestments.com'}
    {'_id': 'brown_mary_jo@lilly.com'}
    {'_id': 'beverly.stephens@enron.com'}
    {'_id': 'ben@crs.hn'}
    {'_id': 'kelly.johnson@enron.com'}
    {'_id': 'julie.cobb@enron.com'}
    {'_id': 'rtwait@graphicaljazz.com'}
    {'_id': 'kimo@tidepool.com'}
    {'_id': 'kbcoventry@yahoo.com'}
    {'_id': 'mcgibbs@pacbell.net'}
    {'_id': 'jlkiley@pacbell.net'}
    {'_id': 'capitolalb@aol.com'}
    {'_id': 'ilan.caplan@enron.com'}
    {'_id': '40enron@enron.com'}
    {'_id': 'fritzdave@aol.com'}
    {'_id': 'ash.menon@enron.com'}
    {'_id': 'harris@enron.com'}
    {'_id': 'sheila.graves@enron.com'}
    {'_id': 'dsahearn@ucdavis.edu'}
    {'_id': 'psterling@mhcable.com'}
    {'_id': 'elliot.mainzer@enron.com'}
    {'_id': 'pat.shortridge@enron.com'}
    {'_id': 'harrisonj@argentgroupltd.com'}
    {'_id': 'amontalbano@pyatok.com'}
    {'_id': 'sandy.hackman@compaq.com'}
    {'_id': 'dlipson@hotmail.com'}
    {'_id': 'keith_larney@i2.com'}
    {'_id': 'higgins@ufl.edu'}
    {'_id': 'garydlindley@visto.com'}
    {'_id': 'mbass@spencerstuart.com'}
    {'_id': 'kevin.jackson@enron.com'}
    {'_id': 'rmoriarity@hotmail.com'}
    {'_id': 'durga@mail.pipingtech.com'}
    {'_id': 'hancha@earthlink.net'}
    {'_id': 'mark.palmer@enron.com'}
    {'_id': 'wallymar@home.com'}
    {'_id': 'tom.siekman@compaq.com'}
    {'_id': 'risarank@peoplepc.com'}
    {'_id': 'fatimapr@softcom.ca'}
    {'_id': 'gay.mayeux@enron.com'}
    {'_id': 'jriley@unavco.ucar.edu'}
    {'_id': 'charlene.jackson@enron.com'}
    {'_id': 'e@melendez.org'}
    {'_id': 'ann.monshaugen@enron.com'}
    {'_id': 'qwest.net@mailman.enron.com'}
    {'_id': 'dbsholes@aol.com'}
    {'_id': 'valbina@nea.org'}
    {'_id': 'pix@visionquestphotography.com'}
    {'_id': 'mlukasiewicz@taz.telusa.com'}
    {'_id': 'adventurehf@pdq.net'}
    {'_id': 'john.sherriff@enron.com'}
    {'_id': 'andreasea@yahoo.com'}
    {'_id': 'dbaker@group1auto.com'}
    {'_id': 'v.chiarito@bernabe.it'}
    {'_id': 'mandylynb23@aol.com'}
    {'_id': 'clayton.vernon@enron.com'}
    {'_id': 'buckeye@thegateway.net'}
    {'_id': 'bridget.canty@mailcity.com'}
    {'_id': 'laurie.franklin@state.mn.us'}
    {'_id': 'terrieg@uclink4.berkeley.edu'}
    {'_id': 'mark.lay@solutioncompany.com'}
    {'_id': 'zachary.streight@enron.com'}
    {'_id': 'jshirley1@houston.rr.com'}
    {'_id': 'jmrtexas@swbell.net'}
    {'_id': 'k_schuller@hotmail.com'}
    {'_id': 'larryc@fidalgo.net'}
    {'_id': 'ckosuda@yahoo.com'}
    {'_id': 'i2@sevista.net'}
    {'_id': 'stevecullen@planetagenda.com'}
    {'_id': 'lafabby@nps.navy.mil'}
    {'_id': 'jelyons@alumni.rice.edu'}
    {'_id': 'joshious@yahoo.com'}
    {'_id': 'howard_scptv@interaccess.com'}
    {'_id': 'james.bannantine@enron.com'}
    {'_id': 'kshroyer@earthlink.net'}
    {'_id': 'kathy_krampien@adp.com'}
    {'_id': 'jhhspark@mindspring.com'}
    {'_id': 'sgd8@cornell.edu'}
    {'_id': 'leslie.moore@compaq.com'}
    {'_id': 'siobhann@mac.com'}
    {'_id': 'john.brindle@enron.com'}
    {'_id': 'prieur3@infolink.com'}
    {'_id': 'sylvia.barnes@enron.com'}
    {'_id': 'thirumalesh_a@hotmail.com'}
    {'_id': 'susheela@weaveincorp.org'}
    {'_id': 'randymonk@hotmail.com'}
    {'_id': 'ravi_nn@hotmail.com'}
    {'_id': 'jfung@mh-a.com'}
    {'_id': 'bc@ori.org'}
    {'_id': 'ahand@tambank.com'}
    {'_id': 'candr@sisqtel.net'}
    {'_id': 'wired@condenast.flonetwork.com'}
    {'_id': 'newsletter@sbsubscriber.com'}
    {'_id': 'ilyse_mckimmie@sundance.org'}
    {'_id': 'mari@rice.edu'}
    {'_id': 'mdahlke1@kingwoodcable.com'}
    {'_id': 'kcoppolino@mobilestar.com'}
    {'_id': 'ethomasb72@aol.com'}
    {'_id': 'niles.donegan@dartmouth.edu'}
    {'_id': 'pwilson@syratech.com'}
    {'_id': 'pegspak@flash.net'}
    {'_id': 'ktands@aol.com'}
    {'_id': 'cdemuth@aei.org'}
    {'_id': 'rachelhayes@writeme.com'}
    {'_id': 'gkarpinski@mindspring.com'}
    {'_id': 'mgdolfin@yahoo.com'}
    {'_id': 'ldemby@aqua.org'}
    {'_id': 'dabakis@kenyon.edu'}
    {'_id': 'cbalmanza@swog.org'}
    {'_id': 'meemaw7@home.com'}
    {'_id': 'chrisolantern@yahoo.com'}
    {'_id': 'russell.diamond@enron.com'}
    {'_id': 'phylis.karas@enron.com'}
    {'_id': 'cheryltd@warrenelectric.com'}
    {'_id': 'peter.blackmore@compaq.com'}
    {'_id': 'lalenaluba@cs.com'}
    {'_id': 'cindy.derecskey@enron.com'}
    {'_id': 'bcazeneuve@consellationfin.com'}
    {'_id': 'srselgolf@athens.net'}
    {'_id': 'kc@lgsdigital.com'}
    {'_id': 'trash@16visions.com'}
    {'_id': 'kammmac@netshel.net'}
    {'_id': 'altacharo@hotmail.com'}
    {'_id': 'carattin@dpw.com'}
    {'_id': 'reedglenn@aol.com'}
    {'_id': 'mccoyh@fiu.edu'}
    {'_id': 'rob.bradley@enron.com'}
    {'_id': 'imisconi@yahoo.com'}
    {'_id': 'ppoint@kink.fm'}
    {'_id': 'ase_development@ase.org'}
    {'_id': 'mcgarrymusic@yahoo.com'}
    {'_id': 'lucy.ortiz@enron.com'}
    {'_id': 'mpcarl@yahoo.com'}
    {'_id': 'joseph.hirl@enron.com'}
    {'_id': 'greetings@reply.yahoo.com'}
    {'_id': 'cdpatt@hsjs.com'}
    {'_id': 'ann.chu@turner.com'}
    {'_id': 'jim.steitz@usu.edu'}
    {'_id': 'schedule@clayfarmer.com'}
    {'_id': 'abrown@iusb.edu'}
    {'_id': 'alipscomb@cffpp.org'}
    {'_id': 'elizabeth@media-enterprises.com'}
    {'_id': 'bourneb@umsystem.edu'}
    {'_id': 'elizabeth.labanowski@enron.com'}
    {'_id': 'briea@hotmail.com'}
    {'_id': 'j.m.stinson@conoco.com'}
    {'_id': 'upset_and_jobless@hotmail.com'}
    {'_id': 'david_kirkpatrick@fortunemail.com'}
    {'_id': 'mayres@lighthouse-energy.com'}
    {'_id': 'sarah321@aol.com'}
    {'_id': 'kabrandt@earthlink.net'}
    {'_id': 'carrollrobinsonforcongress@hypermail.cc'}
    {'_id': 'eamullen@facstaff.wisc.edu'}
    {'_id': 'eyth1@aol.com'}
    {'_id': 'kyle@mountainsplains.org'}
    {'_id': 'allison@firstconf.com'}
    {'_id': 'tyrus@onebox.com'}
    {'_id': 'ns1bo14@inmail.sk'}
    {'_id': 'drex@cablespeed.com'}
    {'_id': 'mike.underwood@enron.com'}
    {'_id': 'promo@nccdsl.com'}
    {'_id': 'ann@consulair.com'}
    {'_id': 'dorothy_trusock@hotmail.com'}
    {'_id': 'esmedley@wpo.org'}
    {'_id': 'terrie.james@enron.com'}
    {'_id': 'ahespenh@yahoo.com'}
    {'_id': 'lcook@globalcrossing.com'}
    {'_id': 'llhhvg@earthlink.net'}
    {'_id': 'audkim@cats.ucsc.edu'}
    {'_id': 'dallred@bcm.tmc.edu'}
    {'_id': 'administration.enron@enron.com'}
    {'_id': 'ohaseeb@ustcs.com'}
    {'_id': 'j..kean@enron.com'}
    {'_id': 'linda.auwers@compaq.com'}
    {'_id': 'pln024@co.santa-cruz.ca.us'}
    {'_id': 'tmartini@glencove.com'}
    {'_id': 'bloomingapricot@aol.com'}
    {'_id': 'bill.miller@uschamber.com'}
    {'_id': 'kuntz@geneseo.edu'}
    {'_id': 'managingdirector@weforum.org'}
    {'_id': 'jrybandt@yahoo.com'}
    {'_id': 'gerryking@austin.rr.com'}
    {'_id': 'billy.dorsey@enron.com'}
    {'_id': 'bmccredie@aqmd.gov'}
    {'_id': 'rivka62@hotmail.com'}
    {'_id': 'ejalvarez1@hotmail.com'}
    {'_id': 'escapade1@attbi.com'}
    {'_id': 'alliancetosaveenergy@ase.org'}
    {'_id': 'oludarebo@yahoo.com'}
    {'_id': 'djackson7777@hotmail.com'}
    {'_id': 'mary.joyce@enron.com'}
    {'_id': 'dan.rittgers@enron.com'}
    {'_id': 'jgaines@wellsstjohn.com'}
    {'_id': 'bill_lewis@mckinsey.com'}
    {'_id': 'peckg@rhodes.edu'}
    {'_id': 'jhutchis@carbon.cudenver.edu'}
    {'_id': 'fran@dollingers.com'}
    {'_id': 'h..sutter@enron.com'}
    {'_id': 'tricebn@pacbell.net'}
    {'_id': 'twill@yahoo.com'}
    {'_id': 'mverdict@ase.org'}
    {'_id': 'michael.norris@enron.com'}
    {'_id': 'lgibson@mail.smu.edu'}
    {'_id': 'dbiele@optonline.net'}
    {'_id': 'kc1tom@aol.com'}
    {'_id': 'alyons@mindspring.com'}
    {'_id': 'compensation.executive@enron.com'}
    {'_id': 'michael.mann@enron.com'}
    {'_id': 'wuelf@aol.com'}
    {'_id': 'tinah53374@aol.com'}
    {'_id': 'dcarey@spencerstuart.com'}
    {'_id': 'dschneider@challiance.org'}
    {'_id': 'chuck.johnson@enron.com'}
    {'_id': 'eleanor.best@bc.edu'}
    {'_id': 'dmyers@atlascapitalservices.com'}
    {'_id': 'rjs@suelthauswalsh.com'}
    {'_id': 'wsimm18284@aol.com'}
    {'_id': 'djtheroux@independent.org'}
    {'_id': 'bernshen@earthlink.net'}
    {'_id': 'lindol2@worldnet.att.net'}
    {'_id': 'sueh223@juno.com'}
    {'_id': 'carole@aemhmr.org'}
    {'_id': 'dgroves@wslc.org'}
    {'_id': 'holly_sf@yahoo.com'}
    {'_id': 'rebecca.longoria@enron.com'}
    {'_id': 'edhodg@aol.com'}
    {'_id': 'duozumi@nyc.rr.com'}
    {'_id': 'fcarl@home.com'}
    {'_id': 'rocky.emery@painewebber.com'}
    {'_id': 'slevine@pobox.com'}
    {'_id': 'peter_burrell@yahoo.com'}
    {'_id': 'caroline@thegrid.net'}
    {'_id': 'melissa@tier1execs.com'}
    {'_id': 'ibuyit@enron.com'}
    {'_id': 'betsy.mcquaid@ucop.edu'}
    {'_id': 'pat@sfa-law.com'}
    {'_id': 'buildingblocks@roundarch.com'}
    {'_id': 'jhb513@aol.com'}
    {'_id': 'apogue@bust.com'}
    {'_id': 'officename1234@aol.com'}
    {'_id': 'jeff_hines@hines.com'}
    {'_id': 'perfmgmt@enron.com'}
    {'_id': 'merkeliii@yahoo.com'}
    {'_id': 'dmr10@axe.humboldt.edu'}
    {'_id': 'sstokes@tbdnetworks.com'}
    {'_id': 'amyb@activate.net'}
    {'_id': 'langharn@maail.strose.edu'}
    {'_id': 'gcarmona@chicagoreader.com'}
    {'_id': 'aruckdes@yahoo.com'}
    {'_id': 'cgoodman@energymarketers.com'}
    {'_id': 'chmoore1@email.msn.com'}
    {'_id': 'president@weforum.org'}
    {'_id': 'robert.davis@enron.com'}
    {'_id': 'james.zane@newline.com'}
    {'_id': 'cgrissom@dvax.com'}
    {'_id': 'jnthnjng@hotmail.com'}
    {'_id': 'numbhand@yahoo.com'}
    {'_id': 'cannon_craig@yahoo.com'}
    {'_id': 'billboedecker@yahoo.com'}
    {'_id': 'gladdy@earthlink.net'}
    {'_id': 'steve.iyer@enron.com'}
    {'_id': 'james.hughes@enron.com'}
    {'_id': 'marymerchant@home.com'}
    {'_id': 'gstachni@ucsd.edu'}
    {'_id': 'skimmel@iexalt.net'}
    {'_id': 'wkiechel@hbsp.harvard.edu'}
    {'_id': 'vanguard@thevanguard.org'}
    {'_id': 'rrossow@uschamber.com'}
    {'_id': 'dzierott@yahoo.com'}
    {'_id': 'cstrebe@bitstream.net'}
    {'_id': 'gsxinternational@hotmail.com'}
    {'_id': 'smcguire@adnc.com'}
    {'_id': 'cmprn107577@gm20.com'}
    {'_id': 'rembrandt@siskiyou.net'}
    {'_id': 'nancy@newcapitolsolutions.com'}
    {'_id': 'angela.williams@enron.com'}
    {'_id': 'natalie@layfamily.com'}
    {'_id': 'shanadew@hotmail.com'}
    {'_id': 'charles@gcfonline.com'}
    {'_id': 'ssmith@uwtgc.org'}
    {'_id': 'aile@mailman.enron.com'}
    {'_id': 'leila@globalexchange.org'}
    {'_id': 'barbara.sain@compaq.com'}
    {'_id': 'baslerasoc@aol.com'}
    {'_id': 'melvin.anderson@enron.com'}
    {'_id': 'lenny.hochschild@enron.com'}
    {'_id': 'lharpold@lrmlaw.com'}
    {'_id': 'sdumont@tides.org'}
    {'_id': 'harpyqueen@yahoo.com'}
    {'_id': 'news@rciinfo.com'}
    {'_id': 'dmacneil@computerpsychologist.com'}
    {'_id': 'tom.donohoe@enron.com'}
    {'_id': 'mgmccarthy@lfd.com'}
    {'_id': 'philomath@earthlink.net'}
    {'_id': 'marymgriffin@attbi.com'}
    {'_id': 'policyprograms@as-coa.org'}
    {'_id': 'bgrizzle@capricornholdings.com'}
    {'_id': 'ecockrel@cockrell.com'}
    {'_id': 'david.delainey@enron.com'}
    {'_id': 'atruppin@mindspring.com'}
    {'_id': 'karen@mpenner.com'}
    {'_id': 'ervala@juno.com'}
    {'_id': 'listadmin@client-mail.com'}
    {'_id': 'deake@cch.com'}
    {'_id': 'maureen.mcvicker@enron.com'}
    {'_id': 'kenneth.thibodeaux@enron.com'}
    {'_id': 'mayorkatz@ci.portland.or.us'}
    {'_id': 'kruse1110@insightbb.com'}
    {'_id': 'tom_talley@ryderscott.com'}
    {'_id': 'felursus@nyc.rr.com'}
    {'_id': 'cole@sigaba.com'}
    {'_id': 'apatel@nsi.edu'}
    {'_id': 'dan.ayers@enron.com'}
    {'_id': 'jeffrey_fountain@bankone.com'}
    {'_id': 'peyton@cais.com'}
    {'_id': 'aaron.berutti@enron.com'}
    {'_id': 'jennwood@wildmail.com'}
    {'_id': 'jtompkins@iexalt.net'}
    {'_id': 'crenshaw_newton_f@lilly.com'}
    {'_id': 'twinflayms@yahoo.com'}
    {'_id': 'mvalles@houston.rr.com'}
    {'_id': 'sem@eaccess.net'}
    {'_id': 'charlie.graham@enron.com'}
    {'_id': 'kristenbradley@earthlink.net'}
    {'_id': 'jjiles@bear.com'}
    {'_id': 'administrator@simmonsco-intl.com'}
    {'_id': 'fburmeister@aimmidwest.com'}
    {'_id': 'leah@echonyc.com'}
    {'_id': 'leslie.milosevich@kp.org'}
    {'_id': 'laura_sarah@hotmail.com'}
    {'_id': 'elsantoss@hotmail.com'}
    {'_id': 'karloo@mediaone.net'}
    Total:  2200
    

2. Contabilize quantos e-mails tem a palavra “fraud”


```python
emails = enron.find({"text": {"$regex": "fraud"}})
count = 0
for e in emails:
    print(e, "\n")
    count += 1
print("Total: ", count)
```

    {'_id': ObjectId('52af48b6d55148fa0c19967e'), 'sender': 'rosalee.fleming@enron.com', 'recipients': ['lizard_ar@yahoo.com'], 'cc': [], 'text': "Good morning, Liz -\n\nI left a message at your home this morning that your Dad would like to speak \nwith you when you have a chance to call.  \n\nRosie\n\np.s. - P. L. and I did early voting the first Saturday available!!  It was \nsuch a good feeling as Tuesdays are tough with trying to get to the office \nand leave in time to vote!!\n\n\n\n\n\nElizabeth Lay <lizard_ar@yahoo.com> on 11/06/2000 09:13:26 AM\nTo: ealvittor@yahoo.com\ncc:  \nSubject: Get out the Vote\n\n\nDear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/\n\n", 'mid': '18701113.1075840286943.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/_sent/153.', 'bcc': [], 'to': ['lizard_ar@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '153.', 'date': '2000-11-06 01:55:00-08:00', 'folder': '_sent', 'subject': 'Re: Get out the Vote'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c199762'), 'sender': 'djtheroux@independent.org', 'recipients': [], 'cc': [], 'text': 'Tue, 12 Dec 2000 18:49:21 -0600\nDate: Tue, 12 Dec 2000 18:49:21 -0600\nMessage-Id: <200012130049.SAA07799@server1.pjdoland.com>\nTo: klay@enron.com\nFrom: David Theroux <DJTheroux@independent.org>\nReply-to: DJTheroux@independent.org\nX-Mailer: Perl Powered Socket Mailer\nSubject: THE LIGHTHOUSE: December 12, 2000\n\nTHE LIGHTHOUSE\n"Enlightening Ideas for Public Policy..."\nVOL. 2, ISSUE 48\nDecember 12, 2000\n\nWelcome to The Lighthouse, the e-mail newsletter of The Independent \nInstitute, the non-partisan, public policy research organization \n<http://www.independent.org>. We provide you with updates of the Institute\'s \ncurrent research publications, events and media programs.\n\n-------------------------------------------------------------\n\nIN THIS WEEK\'S ISSUE:\n1. Pentagon "Shocked" to Find Rivers Dammed with Pork\n2. The Environmental Propaganda Agency\n3. William Lloyd Garrison, Antislavery Crusader\n\n-------------------------------------------------------------\n\nPENTAGON "SHOCKED" TO FIND RIVERS DAMMED WITH PORK\n\nCaptain Louis Renault -- Claude Raines\'s cheerfully duplicitous character in \nthe 1942 film classic "Casablanca" -- asserted glibly that he was "shocked, \nshocked" to learn that gambling was taking place at Rick\'s Cafe. Moments \nlater he was only too happy to collect his gambling earnings for the night.\n\nAll this is by way of preamble to a new Pentagon investigation of fraud in \nmilitary construction. The investigation concluded that three senior Army \nCorps of Engineers officials had, just as one whistle-blowing Corps economist \nhad claimed, engaged in a deceitful campaign to justify what the Washington \nPost called "a billion-dollar construction binge on the Mississippi and \nIllinois rivers."\n\n"The [Pentagon] investigators concluded that the agency\'s aggressive efforts \nto expand its budget and missions, as well as its eagerness to please its \ncorporate customers and congressional patrons, have helped \'create an \natmosphere where objectivity in its analyses was placed in jeopardy,\'" the \nPost reports.\n\n"Even the agency\'s retired chief economist told them that Corps studies were \noften \'corrupt,\' and that several Corps employees cited \'immense pressure\' to \ngreen-light questionable projects."\n\nBureaucratic boondoggles of such magnitude are certainly newsworthy. But they \nare hardly news. Just as the Soviets derided the failures of previous Five \nYear Plans (only to implement new, equally flawed versions), so it seems that \nevery few years the Pentagon uncovers massive corruption and waste in its own \ncentrally planned fiefdom -- only to present a new Plan that operates under \nthe same bad incentives that encouraged prior malfeasance.\n\nWith corruption and waste seemingly "taken care of," the worst pork-barrel \nspenders in Congress and the military are then let off the hook, only to \nenjoy -- like Casablanca\'s Renault and Rick -- an amicable toast to the \nbeginnings of a beautiful new friendship.\n\nFor the Washington Post series on the Army Corp of Engineers boondoggle, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-1.html.\n\nFor a summary of the Independent Institute book, ARMS, POLITICS AND THE \nECONOMY: Historical and Contemporary Perspectives, edited by Robert Higgs, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-2.html.\n\n-------------------------------------------------------------\n\nTHE ENVIRONMENTAL PROPAGANDA AGENCY\n\nWill the neck-to-neck presidential race help reduce -- or intensify -- \npressure for the next president of the United States to score points with \nstatist environmental activists?\n\nExcept on a few controversial issues, a strong case can be made that the \nforty-third President of the United States will wish to portray himself as a \nclose friend of "the environment." President George W. Bush, for example, \nwould face strong pressure to show that he is "bipartisan" in his approach to \nenvironmental protection; whereas President Al Gore would likely attempt to \nwin back those who supported Nader and the Greens.\n\nAll the more reason, then, to call attention to the failures of the current \napproach to environmental protection -- especially those emanating from the \nU.S. Environmental Protection Agency, or, as economist Craig Marxsen terms \nit, the Environmental Propaganda Agency.\n\nThe EPA sometimes employs the language of cost-benefit analysis to illustrate \nits seemingly tremendous success, but it is known to employ it in a highly \nmisleading manner. The EPA claimed, for example, that its Clean Air Act \nprograms produced, from 1970 to 1990, $22.2 trillion dollars in health \nbenefits at a cost of only $523 billion. But, reports Marxsen in THE \nINDEPENDENT REVIEW, "[The EPA\'s] study actually represents a milestone in \nbureaucratic propaganda. Like junk science in the courtroom, the study \nseemingly attempts to obtain the largest possible benefit figure rather than \nto come as close as possible to the truth."\n\nIn conclusion, writes Marxsen, "Without the illusory benefit of all the lives \nsaved, the actual benefits of the Clean Air Act were very modest and probably \ncould have been achieved nearly as well with far less sacrifice. The Clean \nAir Act and its amendments force the EPA to mandate reduction of air \npollution to levels that would have no adverse health effects on even the \nmost sensitive person in the population. The EPA relentlessly presses forward \nin its absurd quest, like a madman setting fire to his house in an insane \ndetermination to eliminate the last of the insects infesting it."\n\nFor more information, see "The Environmental Propaganda Agency," by Craig S. \nMarxsen (THE INDEPENDENT REVIEW, Summer 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-3.html.\n\nFor analysis of other EPA programs, see the Independent Institute book, \nCUTTING GREEN TAPE: Toxic Pollutants, Environmental Regulation and the Law, \nedited by Richard Stroup and Roger Meiners, at \nhttp://www.independent.org/tii/lighthouse/LHLink2-48-4.html.\n\nFor Robert Formaini\'s insightful review of Kip Viscusi\'s important book, \nRATIONAL RISK POLICY (THE INDEPENDENT REVIEW, Winter 1999), see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-5.html.\n\n-------------------------------------------------------------\n\nWILLIAM LLOYD GARRISON, Antislavery Crusader\n\n"I will be as harsh as truth, and as uncompromising as justice. On this \nsubject, I do not wish to think, or speak, or write with moderation.... I \nwill not equivocate -- I will not excuse -- I will not retreat a single inch \n-- and I will be heard."\n     -- William Lloyd Garrison, THE LIBERATOR, January 1, 1831\n\nDecember 12 marks the 195th anniversary of the birth of William Lloyd \nGarrison, a leading figure in the American abolitionist movement. As the late \nhistorian Henry Mayer explained in his National Book Award-Finalist \nbiography, ALL ON FIRE: William Lloyd Garrison and the Abolition of Slavery:\n\n"William Lloyd Garrison (1805-1879) is an authentic American hero who, with a \nBiblical prophet\'s power and a propagandist\'s skill, forced the nation to \nconfront the most crucial moral issue in its history. For thirty-five years \nhe edited and published a weekly newspaper in Boston, THE LIBERATOR, which \nremains today a sterling and unrivaled example of personal journalism in the \nservice of civic idealism.\n\n"Although Garrison -- a self-made man with a scanty formal education -- \nconsidered himself \'a New England mechanic\' and lived outside the precincts \nof the American intelligentsia, he nonetheless did the hard intellectual work \nof challenging orthodoxy, questioning public policy, and offering a luminous \nvision of a society transformed. He inspired two generations of activists -- \nfemale and male, black and white -- and together they built a social movement \nwhich, like the civil rights movement of our own day, was a collaboration of \nordinary people, stirred by injustice and committed to each other, who \nachieved a social change that conventional wisdom first condemned as wrong \nand then ridiculed as impossible."\n\nIndeed, without Garrison\'s inflammatory but compelling writing, speaking and \norganizing, there might have been no effective American anti-slavery movement \nat all.\n\nFor more on William Lloyd Garrison, read historian Henry Mayer\'s talk from \nthe Independent Policy Forum, "The Civil War: Liberty and American Leviathan" \n(with Jeffrey Rogers Hummel), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-6.html, or hear it in \nRealAudio at http://www.independent.org/tii/lighthouse/LHLink2-48-7.html.\n\nAlso see Jeffrey Rogers Hummel\'s review of Henry Mayer\'s brilliant biography, \nALL ON FIRE: William Lloyd Garrison and the Abolition of Slavery (THE \nINDEPENDENT REVIEW, Fall 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-8.html.\n\n-------------------------------------------------------------\n\nIf you enjoy receiving THE LIGHTHOUSE ... please help us support it.\n\nYour supporting Independent Associate Membership enables us to reach \nthousands of other people. So, please make a contribution to The Independent \nInstitute. See http://www.independent.org/tii/lighthouse/LHLink2-48-9.html. \nto donate, or contact Ms. Priscilla Busch by phone at 510-632-1366 x105, fax \nto 510-568-6040, email to <PBusch@independent.org>, or snail mail to The \nIndependent Institute, 100 Swan Way, Oakland, CA 94621-1428.\nAll contributions are tax-deductible.  Thank you!\n\n-------------------------------------------------------------\n\nFor previous issues of THE LIGHTHOUSE, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-10.html.\n\n-------------------------------------------------------------\n\nFor information on books and other publications from The Independent \nInstitute, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-11.html.\n\n-------------------------------------------------------------\n\nFor information on The Independent Institute\'s Independent Policy Forums, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-12.html.\n\n-------------------------------------------------------------\n\nTo subscribe (or unsubscribe) to The Lighthouse, please go to \nhttp://www.independent.org/subscribe.html, choose "subscribe" (or \n"unsubscribe"), enter your e-mail address and select "Go."\n\nCopyright , 2000 The Independent Institute\n100 Swan Way\nOakland, CA 94621-1428\n(510) 632-1366 phone\n(510) 568-6040 fax\ninfo@independent.org\nhttp://www.independent.org\n', 'mid': '23245619.1075840229215.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/all_documents/1021.', 'bcc': [], 'to': [], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '1021.', 'date': '2000-12-12 10:37:00-08:00', 'folder': 'all_documents', 'subject': ''} 
    
    {'_id': ObjectId('52af48b6d55148fa0c199a91'), 'sender': 'lizard_ar@yahoo.com', 'recipients': ['ealvittor@yahoo.com'], 'cc': [], 'text': "Dear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/", 'mid': '27820033.1075840221053.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/all_documents/743.', 'bcc': [], 'to': ['ealvittor@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '743.', 'date': '2000-11-05 23:13:00-08:00', 'folder': 'all_documents', 'subject': 'Get out the Vote'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c199a92'), 'sender': 'rosalee.fleming@enron.com', 'recipients': ['lizard_ar@yahoo.com'], 'cc': [], 'text': "Good morning, Liz -\n\nI left a message at your home this morning that your Dad would like to speak \nwith you when you have a chance to call.  \n\nRosie\n\np.s. - P. L. and I did early voting the first Saturday available!!  It was \nsuch a good feeling as Tuesdays are tough with trying to get to the office \nand leave in time to vote!!\n\n\n\n\n\nElizabeth Lay <lizard_ar@yahoo.com> on 11/06/2000 09:13:26 AM\nTo: ealvittor@yahoo.com\ncc:  \nSubject: Get out the Vote\n\n\nDear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/\n\n", 'mid': '23851178.1075840221079.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/all_documents/744.', 'bcc': [], 'to': ['lizard_ar@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '744.', 'date': '2000-11-06 01:55:00-08:00', 'folder': 'all_documents', 'subject': 'Re: Get out the Vote'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c199b8d'), 'sender': 'peter.blackmore@compaq.com', 'recipients': ['babbio@verizon.com', 'lynnj@iname.com', 'ted.enloe@compaq.com', 'ghh@telcordia.com', 'klay@enron.com', 'kjewett@kpcb.com', 'kenroman@worldnet.att.net', 'lucie@jhmedia.com', 'michael.capellas@compaq.com', 'michael.capellas@compaq.com'], 'cc': ['michael.capellas@compaq.com'], 'text': 'Pleased to send you the November report. Obviously the market is weakening\nin North America which is making the quarter challenging but the underlying\nmomentum of the company continues to improve as the report illustrates.\nLook forward to seeing you at the Board meeting.\n\nRegards,\nPeter\n\n\n\n> [Compaq Confidential - Internal Use Only]\n>\n> To:  Global Sales & Services Team\n>\n> Before I report on the great wins and other news this month, I want to\n> express a personal note about the organizational announcement earlier this\n> month.  I\'m excited about the changes for all the reasons already\n> communicated - in particular strengthening the integration of our upstream\n> and downstream operations.  I\'m also excited about Bo McBee and his\n> worldwide team in Corporate Quality and Customer Satisfaction officially\n> joining our organization.  He and his team are doing a great job, and\n> together we will further our efforts to become the leader throughout the\n> world in satisfying our customers.\n>\n> Most of all, I am extremely pleased and encouraged because I believe these\n> changes confirm the great work you have accomplished this year.  We\'ve\n> already reported a number of major wins as a result of the joint efforts\n> by our Sales and Services teams.  There is an air of excitement and\n> anticipation about Compaq\'s momentum - I see it in the emails from many of\n> you and as I meet with our teams and customers around the world.  You\'re a\n> remarkable team and, as Michael puts it, let\'s keep the pedal to the metal\n> and keep the momentum strong as we work to successfully close 2000!\n>\n> Speaking of my travels...\n> This month I visited Johannesburg, South Africa, Dubai within the United\n> Arab Emirates, and Saudi Arabia.  All of these countries are part of\n> EMEA\'s Business Development Group (BDG), which is responsible for\n> developing Compaq business in 98 countries. The group is focused on both\n> developed and emerging markets in Eastern Europe, the Middle East and\n> Africa. Over the past six years, BDG has grown its revenue more than\n> 10-fold.\n>\n> In South Africa I visited Vodacom, which with 4 million subscribers, is\n> Africa\'s largest mobile phone network operator.  The company has just\n> upgraded its billing systems to handle further expansion, and to date is\n> one of the world\'s largest Wildfire installations with some 21 AlphaServer\n> GS systems.  I also spent time with the management of Mobile Telephone\n> Networks (MTN), South Africa\'s #2 cellphone operator and another big\n> Wildfire customer.  In fact, we just got word that they\'ve placed a $10M\n> order for four GS320 AlphaServer systems and storage.\n>\n> One of my more interesting activities while there was learning more about\n> Ikageng, a Compaq-led initiative to bring the benefits of the information\n> age to the rural communities of Africa.  Ikageng brings together the\n> provision of safe drinking water, affordable healthcare, distance\n> learning, improved subsistence farming techniques and Internet access.\n> All of this is co-funded by a community bank, together with Compaq,\n> Johnnic, a South African media and information group, and the active\n> participation of the World Bank.  A real example of Inspiration Technology\n> at work!\n>\n> My visit to the United Arab Emirates included a dinner with our top 30\n> customers from across the region, a VIP lunch with our top partners, as\n> well as meetings with employees in the region.  I also attended Gitex, the\n> region\'s largest IT exhibition, and met with press at that event to convey\n> Compaq\'s commitment to the UAE.  I was also privileged to have a personal\n> meeting with His Highness Sheik Mohamad bin Rashid al Maktoum, Crown\n> Prince of Dubai and the Minister of Defense.  These meetings were around\n> the official opening of Dubai Internet City, an area of Dubai dedicated to\n> making the city the "Silicon Valley"  of the Middle East.\n>\n> I spent a very interesting day at Aramco in Saudi Arabia, our largest\n> account in the UAE. We are the ProLiant standard in this very large energy\n> company and we have a great opportnuity to build a strong partnership\n> across many additional solutions including high performance technical\n> computing, ZLE applications and enterprise storage, in addition to\n> recapturing client business from the competition\n>\n> Some of our largest wins this month\n> * Tokyo Stock Exchange - We are replacing Hitachi at the world\'s third\n> largest stock exchange, with a $60-80M order for Himalaya systems. This\n> contract should bring in an additional $20-30M in Professional Services.\n> *      Eli Lilly - Signed the first leg of a three-year global agreement\n> valued at $100M, securing Compaq as the sole supplier for Intel-based\n> products, forcing Dell off the customer\'s standards list and opening the\n> door for StorageWorks products, Global Services and high-performance\n> servers.\n> *      Winstar - Four-year, $100M contract as the exclusive provider of\n> Windows NT and storage products, including $10M in AlphaServer systems\n> running Tru64 UNIX.\n> *      Mead Corp. - Beat IBM, HP and Dell for a five-year, $50M contract\n> for ProLiant servers, storage, desktops, portables and services.\n> * France Telecom - $30M contract for a global agreement (includes all\n> subsidiaries) for a complete line of AlphaServer systems, including DS, ES\n> and GS series as well as ProLiant servers.\n> * General Motors - Selected as the global Intel-based server standard\n> for new application deployment at GM manufacturing facilities. The\n> anticipated global revenue is $30M over three years.\n> * Electronic Classroom of Tomorrow - $25M for ProLiant 8500 servers,\n> StorageWorks products and legacy-free iPAQ desktops.\n> * FleetBoston Financial - Beat IBM, Dell and HP for a $40M desktops\n> contract\n> * Airgroup (Switzerland) - Beat IBM and NetVista for a  $21M contract\n> for 20,000 iPAQ desktops.\n> * DLI (Korea) - $22M for Professional Services.\n> * AltaVista - Shut out IBM and HP by putting into place a $25M fair\n> market value lease for ProLiant- and Alpha-based servers, increasing the\n> AltaVista lease line to $75M.\n> * ASP Host Centric - One of the eight North America-certified Oracle\n> Authorized Application Providers (OAAP), the firm will standardize its\n> UNIX environment on AlphaServers, replacing Sun systems. This project\n> could generate more than $20M for us over the next 36 months.\n> * Interfusion - Three-year, $20M contract for a Tru64 UNIX-based\n> solution.\n> * Westcoast Energy- Topped Dell for a desktop and portables contract\n> valued between $15-20M.\n> * General Electric - Five-year, $15.4M contract for worldwide Lotus\n> Domino rollout and expansion of Exchange rollout, including NT Server\n> management outsourcing.\n> http://newscpq1.inline.cpqcorp.net/article.cfm?storyid=1146\n> * Moebel Pfister - $15.7M outsourcing contract.\n> * TriRiga - Beat Dell, EMC and Sun for a two-year, $15M contract for\n> storage, Professional Workstations, desktops, portables and services.\n>\n> EMEA to open Wireless Competence Centre in Stockholm\n> Press, customers and partners have been invited to help officially open\n> the Compaq Wireless Competence Centre in Stockholm, Sweden, on November\n> 27.  The centre is the company\'s first facility to fully display our\n> unique end-to-end capabilities of  solutions, services and products in the\n> mobile Internet and wireless space.  The hands-on centre showcases today\'s\n> wireless solutions within four environments - car, home, office and public\n> access areas.  Technologies featured include GSM, GPRS, future 3G\n> standards, WLAN and Bluetooth.  Compaq\'s mobile partners such as Nokia,\n> Oracle, Cisco, Microsoft, Siebel and Ericsson also plan to participate in\n> the opening.  The centre is already hosting customer visits and will\n> engage with thousands of customer and partners over the coming year\n> through a mix of seminars, tours and customized workshops.  For more info,\n> see  http://inline-se.soo.cpqcorp.net/wireless/\n>\n> Planning for Innovate Forum 2001 under way\n> Compaq\'s premier event for its global and large account customers -\n> Innovate Forum 2001 - is set for May 23-24 at the George R. Brown\n> Convention Center in Houston.  The hand-picked guest list will include\n> some 4,000-5,000 senior-level technical and business executives, including\n> our key channel partners, press, industry and financial analysts, and\n> Compaq\'s key alliance partners.  The program will feature keynote\n> speeches, plenary sessions, special interest seminars, a solutions\n> pavilion, and social events.  For more information, see the Innovate site\n> on Inline:  http://inline.compaq.com/na/innovate/\n>\n> Cross Border Office files first lawsuit\n> The Cross Border Office has been created to prevent unauthorized movement\n> of Compaq products by dealers and gray market brokers in order to protect\n> profit margins and ultimately, customer satisfaction.  The Cross Border\n> team provides gray market awareness training to all sales personnel, mail\n> and phone hotline access to report gray market activity, works jointly\n> with regional sales, services, business unit and channel teams to create\n> policy and procedures to reduce gray market activity and, working with the\n> Law department, to bring legal action against gray market brokers if\n> warranted.\n>\n> As a result of these efforts, Compaq has filed its first lawsuit against\n> two Canadian technology consulting firms for breach of contract and fraud.\n> The suit, which seeks compensatory damages of more than $17 million,\n> claims the consulting firms fraudulently represented to Compaq that they\n> had a contract with the U.S. Department of Transportation\'s Federal\n> Aviation Administration to supply a large number of computers and related\n> equipment to U.S. airports. This lawsuit hit many national publications\n> and sends a message to the worldwide gray market community that Compaq\n> will take actions to protect its authorized resellers, product quality and\n> our customers.\n>\n> For further information on the Cross Border Office, gray market red flags\n> and to view the web-based training video, see\n> http://inline.compaq.com/wwsm/crossborder/index.asp\n>\n> Key Channel Partner programs rolling out\n> Early this year the Tigerbite project was established to redefine and\n> simplify Compaq\'s model with our channel partners.  A key element of the\n> model is worldwide programs that provide profitable growth opportunities\n> for Compaq and its partners.  Two such programs - Internet List Pricing\n> (ILP) and the Compaq Agent Program - are currently being implemented by\n> the regions.\n>\n> Worldwide implementation of ILP is a top priority for the company.\n> Creating and publishing (where needed) competitive List Prices is\n> absolutely essential to establishing a more consistent, worldwide pricing\n> model for both our customers and partners. By the end of this month ILP\n> will have been implemented in North America, Latin America, Japan and\n> Greater China, with pilot programs in Singapore and Malaysia.  EMEA and\n> the remaining Asia Pacific countries are expected to complete the rollout\n> by January 1, 2001.\n>\n> The Compaq Agent Program, which allows partners to earn commissions when\n> they refer customers to purchase products/services directly from us,\n> currently has been implemented in the U.S., Latin America (14 countries)\n> and CKK.  This month, APD is implementing pilot programs in Singapore and\n> Malaysia, and plans to roll out the program in seven additional countries\n> in the first quarter.  EMEA held an Agent Program Summit this month with\n> 10 countries to assess and develop their 2001 rollout plans which include\n> adding Enterprise-class products to their program next year.\n>\n> News from the Compaq Alliances team\n> *      Compaq regained the #1 platform partner position with SAP with 33%\n> market share over all platforms (NT, UNIX with R/3, and mySAP.com). IBM is\n> 2nd in line with 23% share. In North America alone, our overall SAP share\n> increased from 25% to 32% in the third quarter.  As an aside, SAP\'s entire\n> executive board and senior executive staff use our iPAQ Pocket PCs.\n> Rollout of the product to SAP Sales and Marketing is also in progress -- a\n> very visible endorsement of Compaq\'s leadership in Internet access as it\n> applies to enterprise applications.\n> * Cable & Wireless CEO and executive visit to Marlboro in October\n> included CEO Graham Wallace and 56 top C&W executives. C&W new ASP\n> \'a-Services\' UK launch on October 31 followed the successful U.S. launch\n> in late September.\n> * Compaq secured the notebook business with CGE&Y UK for their\n> internal use.  Toshiba had been the incumbent for 5 years.  CGE&Y is\n> upgrading to Oracle 11i on Alpha Tru64 UNIX.  As one of the first\n> customers globally to upgrade to 11i on Alpha, they have agreed to be a\n> reference site.\n> * Our successful Platinum Sponsorship of Commerce One\'s Global Trading\n> Web Technical Forum included a Compaq keynote and non-disclosure breakout\n> session on new ProLiant 8-ways.\n> * A  9-city roadshow in EMEA was kicked-off with Intel, starting in\n> Munich.  This is an extension of the successful 11 city roadshow in the\n> U.S. that drove traffic to the speedStart website and should do the same\n> for EMEA..\n> * Strong Compaq presence with Premier sponsorship at Oracle Open World\n> in October included Michael Capellas luncheon speech to 200+ C-level\n> customers, on-stage server presence at Larry Ellison keynote, and\n> excellent Compaq coverage in Oracle publications.\n> * Announced major Mid-Market Initiative Contract with Siebel.  We had\n> very high visibility at Siebel User Week, and also won Siebel\'s Platform\n> Partner of the Year awards for Excellence in EMEA and NA.  We recently\n> announced a Benchmark Figure of 10,200 Siebel users running Microsoft NT\n> and SQL 7 on ProLiant systems.\n> * Compaq had a strong presence at COMDEX with strategic partner,\n> Microsoft.  In addition to  supporting Bill Gates\' keynote address, the\n> Microsoft booth featured iPAQ Pocket PCs demonstrating the award-winning\n> OmniSky wireless Internet and e-mail service running on Metricom\'s\n> Ricochet network - the world\'s fastest mobile broadband network.\n> Microsoft also announced the immediate availability of its Windows Media\n> Player Technology Preview Edition on Compaq Pocket PCX devices, which for\n> the first time delivers streamed wireless Windows Media-formatted audio\n> and video to a portable device.\n>\n> Global Accounts news\n> * Do you know about the Discovery, Design and Implementation (DDI)\n> application? Global Accounts has moved the DDI application into\n> production, resulting in a Web-enabled tool that streamlines and automates\n> the DDI phases for signing up new customers.\n> http://vinproapp03.cce.cpqcorp.net/ddi/\n> * More than 130 people from Compaq EMEA Global Accounts attended a\n> conference center at EuroDisney, Paris, for a training program that\n> included a focus on personal development skills and a broader look at how\n> Global Accounts can build sales.\n\n> * A CD and brochure designed to give Global Accounts salespeople and\n> customers a greater insight into the business can be ordered online\n> through the GA catalog.\n> http://inline.compaq.com/corpmktg/globalaccounts/know/resourcekit.asp\n> * For the first time, Compaq has a single, documented global special\n> pricing process, enabling us to be smarter than the competition on global\n> bids.  Implementation of this process is expected to begin January 1. For\n> more information, see\n> http://inline.compaq.com/corpmktg/globalaccounts/div/stratplan/index.asp\n> or e-mail Philip Kyle.\n> * Global Account managers and others whose customers and prospects\n> require multi-platform hardware, operating systems and applications will\n> want to know about the IQ Center. With more than 150 systems engineering\n> personnel, 30,000 square-feet of lab space, 500 CPUs and 100 TB of\n> storage, the Center is a well-equipped, one-stop shop for designing and\n> testing complex solutions.\n> http://inline.compaq.com/corpmktg/globalaccounts/div/gamclose.asp\n>\n> CPCG headlines\n> * Compaq regained total PC and PC server market share leadership in\n> the UK during 3Q.\n> * Among our many announcements at Comdex, we introduced the\n> three-pound, MP2800 - the world\'s smallest projector -- as well as\n> iPAQnet, a collection of products and solutions designed to redefine the\n> Internet experience for customers demanding wireless access to e-mail and\n> other corporate information. Last, Compaq and Oracle announced an all-new\n> Internet appliance based on ProLiant servers and the latest Oracle\n> software to deliver the fastest cache on the Internet. Oracle is backing\n> up the performance pledge with a $1 million guarantee.\n>\n> Ratings and reviews\n> * Computer Shopper named the iPAQ Pocket PC one of the "Top 100\n> Products of 2000"\n> * "Looking for the perfect present for the technophile who has\n> everything? Then check out the Compaq iPAQ Pocket PC ... the iPAQ is a lot\n> slimmer than most of the competition ... Plus, its brilliant 12-bit,\n> 4,096-color reflective display will be sure to make the holiday season\n> especially bright." - ZDNet\n> * Popular Science recognized the iPAQ Pocket PC at an awards ceremony\n> for being one of the year\'s 100 "hottest products and eye-opening\n> discoveries." The iPAQ Pocket PC is pictured on the cover of the\n> magazine\'s December edition, now on newsstands.\n> * "Sure, the Compaq iPAQ Pocket PC PDA has everything a desktop PC has\n> - word processor, Internet browser, e-mail engine, etc., etc. But that\'s\n> not even half the story: It can crank out color video and blast MP3 music\n> through a stereo headphone jack..." - Stuff Magazine\n>\n> Portables garner praise\n> * The Armada E500S received the "Four-Star Award" from Computer\n> Shopper. "Overall, the Armada E500S is a compelling, well-designed package\n> for small businesses ... you get a solid mix of components for the money."\n> - Computer Shopper\n> * The Notebook 100 was named one of the Top 100 Products of the Year\n> by Computer Shopper. "We were duly impressed with Compaq\'s price-defying\n> Notebook 100."\n>\n>\n> Consumer Group highlights\n> * Last month, we shipped our 500,000th Configure-to-Order unit. U.S.\n> CTO sales grew 256% in the third quarter.\n> * Worldwide beyond-the-box revenue in Q3 increased 90% year-over-year.\n> * Of the top 25 countries with the highest Consumer sales worldwide,\n> six are in the Latin America region: Mexico (2), Brazil (4), Argentina\n> (8), Chile (16), Peru/Bolivia (21) and Colombia (22).\n> * Consumer\'s EMEA region hit the $1 billion sales mark in mid-October,\n> two months earlier than in 1999.\n> * More than 50,000 DSL-ready Presario computers have been sold through\n> our deal with Southwestern Bell.\n> http://newscpq1.inline.cpqcorp.net/article.cfm?storyid=1034\n> * Popular Science magazine included the iPAQ Home Internet Appliance\n> in its "Best of What\'s New" in the computer and software category.\n>\n> Storage Product Group news\n> *      Compaq Belgium and Luxembourg have won four DATANEWS Awards for\n> Excellence, one of which was in the category of Enterprise Storage: Compaq\n> StorageWorks systems. Compaq also received Awards of Excellence for\n> Enterprise Server (ProLiant); High-End Workstations (Compaq Professional\n> Workstation), and Services. The Compaq Aero Professional Digital Assistant\n> (PDA) received a Quality Award. For more info, visit:\n> http://datanews.vnunet.be/dnafe0.asp\n> *      An elite group of storage networking companies has joined our\n> commitment to support VersaStor Technology - the industry\'s premier\n> implementation of networked storage pooling. These endorsements represent\n> an important milestone in enabling SAN customers to leverage business\n> information as a virtual resource.\n> http://www.compaq.com/newsroom/pr/2000/pr2000103002.html\n> * Construction has begun on the Storage Networking Industry\n> Association Technology Center (SNIA Technology Center) in Colorado\n> Springs, Colo. Upon completion, the 14,000-square-foot center will be the\n> largest independent storage networking lab in the world.\n> http://storage.inet.cpqcorp.net/download/doc/SNIA_Release_final.doc\n> * At last month\'s Storage Networking World conference, Compaq and IBM\n> demonstrated for the first time true multi-vendor online storage\n> interoperability for the Open SAN Earlier this month we announced three\n> new storage service offerings that accelerate SAN implementation, improve\n> enterprise backup performance and increase availability and reliability of\n> remote storage management.\n> http://www.compaq.com/newsroom/pr/2000/pr2000103001.html\n>\n> Business Critical Server Group highlights\n> * Our Tru64 UNIX business is gaining momentum - growing twice as fast\n> as the market in Q2 and Q3 of this year, according to International Data\n> Corp. IDC reports that Compaq was the fastest growing UNIX vendor in Q2,\n> with 25% growth versus overall UNIX market growth of 13%.\n> * On Oct. 31, we announced new Tru64 UNIX, TruCluster and AlphaServer\n> products and services enhancements to improve scalability and ease of\n> deployment for e-business solutions.\n> http://alphaserver.inet.cpqcorp.net/announcements/30oct00/index.html\n> * The International Tandem Users\' Group (ITUG) Summit 2000, held Oct.\n> 15-19 in San Jose, Calif., was the largest ever, drawing 2,900 customers,\n> partners, internal developers and executives. A highlight of the general\n> session was a live demonstration of the Zero Latency Enterprise\n> architecture for customer relationship management, which brings together\n> Himalaya, AlphaServer and ProLiant platforms.\n>\n> North America eBusiness Solutions successes\n> *      Service Provider Winstar has signed Compaq as its exclusive\n> provider of NT and storage products and committed to purchase a minimum of\n> $100M of Compaq products over the next four years, $10M of which will be\n> for Alpha UNIX for their rapidly growing complex hosting business.  We\'re\n> also providing $50M in financing directly to Winstar and $50M in financing\n> to approved Winstar customers.  Compaq Services has been designated as a\n> Winstar Services Partner.\n> *      Exodus placed an initial order of more than 500 ProLiant servers\n> for their Intel-managed hosting platform.\n> * Compaq also inked a deal with Siebel Systems to create a dedicated\n> partner sales channel and a $30M joint marketing initiative for an\n> integrated hardware/software offering to small and medium enterprises.\n> Over 80 sales agents are being authorized to sell the packages, which are\n> delivered fully integrated by Compaq Direct.\n>\n> Compaq Financial Services making a difference\n> *      Compaq Financial Services was instrumental in helping to shut out\n> IBM and HP from long-time Compaq customer AltaVista by putting into place\n> a $25M fair market value lease for NT and AlphaServers.  Through the deal,\n> CFS increased Alta Vista\'s lease line to $75M.\n> * CFS scored its first local currency financing in Brazil with a $3M\n> deal for servers and services.  In awarding the contract over competitors\n> HP and IBM and their respective financing groups, Ericsson cited\n> differentiating factors including Compaq\'s technology and our ability to\n> provide a competitive price in local currency.  CFS invoicing\n> capabilities, including information for each separate Ericsson cost center\n> in Brazil, was also a deciding factor.\n> * CFS helped facilitate the largest delivery of Intel servers\n> (ProLiant ML 370) to the Czech Republic through a $2.8M, 3-year operating\n> lease transaction with Czech Savings Bank.  CFS was the only leasing\n> company to offer a sub-lease structure, a differentiating factor that won\n> the business over Dell and IBM.\n>\n> CEI changes name to Compaq Direct\n> Custom Edge Inc., a wholly owned Compaq subsidiary formed, is now called\n> Compaq Direct. In other "direct" news, did you know that we have more than\n> 230 major accounts now buying from us directly and more in the pipeline?\n> Combined revenue in Q3 from PartnerDirect, DirectPlus, Major Account\n> Direct and GEM Direct totaled nearly 40 percent of CPCG\'s total revenue in\n> North America. What\'s more, ISSG revenue was more than 27 percent direct\n> in Q3.\n>\n> Siebel\'s Platform Partner of the Year\n> I\'m pleased to report that Siebel has named Compaq its Platform Partner of\n> the Year for excellence in both EMEA and North America. We recently\n> received high visibility at the Siebel User Week event while also\n> announcing a record benchmark of 10,200 Siebel users running Microsoft NT\n> and SQL 7 on ProLiant servers.\n>\n> Get Informed\n> Inform, Compaq\'s customer magazine, is now available in printed and\n> electronic versions. It\'s free and available for you to read. Sign your\n> customers up by visiting the U.S. (www.compaq.com/inform/issues/sb.html),\n> Asia Pacific (www.compaq.com.tw/) or EMEA (www.compaq.com/emea/inform)\n> sites.\n>\n> North America eCommerce and CRM marketing activities\n> * North America recently released IMPAQ express, a Web-based tool for\n> Customer Relationship Management (CRM) campaign planning and audience\n> sizing, to its marketing and sales force. For the first time, campaign\n> planning can start with a quick and easy look at the size and scope of a\n> potential installed-based audience.\n> * Compaq recently co-sponsored eLink, a B2B e-commerce event targeted\n> at procurement, IT, marketing and financial executives hosted by Commerce\n> One in Las Vegas. Attendees witnessed the on-stage construction of a live\n> e-marketplace powered by Commerce One and Compaq servers. In addition, we\n> demonstrated our Roundtrip configuration and Auction capabilities.\n>\n> Wins Around the World\n> As always, thanks to everyone for your tremendous efforts this month.\n> Please take a few minutes to look over the complete list of recent wins\n> around the world and continue to write me with your news and success\n> stories. http://inline.compaq.com/wwss/wins/worldwins.asp\n>\n> Let\'s finish the quarter strongly!!\n>\n> Regards,\n> Peter\n>\n> ', 'mid': '18292115.1075840227933.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/all_documents/973.', 'bcc': ['michael.capellas@compaq.com'], 'to': ['babbio@verizon.com', 'lynnj@iname.com', 'ted.enloe@compaq.com', 'ghh@telcordia.com', 'klay@enron.com', 'kjewett@kpcb.com', 'kenroman@worldnet.att.net', 'lucie@jhmedia.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '973.', 'date': '2000-12-05 02:05:00-08:00', 'folder': 'all_documents', 'subject': 'November Blackmore Report'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c199bc0'), 'sender': 'mcgarrymusic@yahoo.com', 'recipients': ['klay@enron.com', 'mcgarrymusic@yahoo.com', 'mcgarrymusic@yahoo.com'], 'cc': ['mcgarrymusic@yahoo.com'], 'text': "Ann McGarry\n75 Hillcrest Avenue\nRye Brook, NY 10573\nmcgarrymusic@yahoo.com\n\nTo Mr. Ken Lay,\n\nI'm writing to demand that you disgorge the millions of dollars you intentionally made from fraudulently selling Enron stock before the company declared bankruptcy, to funds such as Enron Employee Transition Fund and REACH, that benefit the company's employees, who lost their retirement savings, and provide relief to low-income consumers in California, who can't afford to pay their energy bills.  Enron and you made millions out of the pocketbooks of California consumers and from the efforts of your employees.  You are a disgrace to the human race and I hope that you and your kind suffer the kind of punishment you really deserve.\n\nWhile you netted well over a $100 million, many of Enron's employees were financially devastated when the company declared bankruptcy and their retirement plans were wiped out.  And Enron made an astronomical profit during the California energy crisis last year.  As a result, there are thousands of consumers who are unable to pay their basic energy bills and the largest utility in the state is bankrupt.\n\nThe New York Times reported that you sold $101 million worth of Enron stock while aggressively urging the company's employees to keep buying it. You are disgusting. It seems to me that anyone who is so in the grip of out-of-control GREED as you and the others of your kind in this country, e.g., Bush, Cheney, Lott, etc., are actually mentally ill.  No other explanation suffices.  It would be in your best interests to donate your ill-gotten gains to the funds set up to help repair the lives of those Americans hurt by Enron's underhanded dealings.\n\nWith contempt,\n\nAnn McGarry", 'mid': '24474647.1075860832933.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/deleted_items/1008.', 'bcc': ['mcgarrymusic@yahoo.com'], 'to': ['klay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '1008.', 'date': '2002-01-30 09:57:12-08:00', 'folder': 'deleted_items', 'subject': 'Demand Ken Lay Donate Proceeds from Enron Stock Sales'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a246'), 'sender': 'lizard_ar@yahoo.com', 'recipients': ['ealvittor@yahoo.com'], 'cc': [], 'text': "Dear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/", 'mid': '4551221.1075840247043.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/discussion_threads/606.', 'bcc': [], 'to': ['ealvittor@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '606.', 'date': '2000-11-05 23:13:00-08:00', 'folder': 'discussion_threads', 'subject': 'Get out the Vote'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a247'), 'sender': 'rosalee.fleming@enron.com', 'recipients': ['lizard_ar@yahoo.com'], 'cc': [], 'text': "Good morning, Liz -\n\nI left a message at your home this morning that your Dad would like to speak \nwith you when you have a chance to call.  \n\nRosie\n\np.s. - P. L. and I did early voting the first Saturday available!!  It was \nsuch a good feeling as Tuesdays are tough with trying to get to the office \nand leave in time to vote!!\n\n\n\n\n\nElizabeth Lay <lizard_ar@yahoo.com> on 11/06/2000 09:13:26 AM\nTo: ealvittor@yahoo.com\ncc:  \nSubject: Get out the Vote\n\n\nDear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/\n\n", 'mid': '21836611.1075840247067.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/discussion_threads/607.', 'bcc': [], 'to': ['lizard_ar@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '607.', 'date': '2000-11-06 01:55:00-08:00', 'folder': 'discussion_threads', 'subject': 'Re: Get out the Vote'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a340'), 'sender': 'peter.blackmore@compaq.com', 'recipients': ['babbio@verizon.com', 'lynnj@iname.com', 'ted.enloe@compaq.com', 'ghh@telcordia.com', 'klay@enron.com', 'kjewett@kpcb.com', 'kenroman@worldnet.att.net', 'lucie@jhmedia.com', 'michael.capellas@compaq.com', 'michael.capellas@compaq.com'], 'cc': ['michael.capellas@compaq.com'], 'text': 'Pleased to send you the November report. Obviously the market is weakening\nin North America which is making the quarter challenging but the underlying\nmomentum of the company continues to improve as the report illustrates.\nLook forward to seeing you at the Board meeting.\n\nRegards,\nPeter\n\n\n\n> [Compaq Confidential - Internal Use Only]\n>\n> To:  Global Sales & Services Team\n>\n> Before I report on the great wins and other news this month, I want to\n> express a personal note about the organizational announcement earlier this\n> month.  I\'m excited about the changes for all the reasons already\n> communicated - in particular strengthening the integration of our upstream\n> and downstream operations.  I\'m also excited about Bo McBee and his\n> worldwide team in Corporate Quality and Customer Satisfaction officially\n> joining our organization.  He and his team are doing a great job, and\n> together we will further our efforts to become the leader throughout the\n> world in satisfying our customers.\n>\n> Most of all, I am extremely pleased and encouraged because I believe these\n> changes confirm the great work you have accomplished this year.  We\'ve\n> already reported a number of major wins as a result of the joint efforts\n> by our Sales and Services teams.  There is an air of excitement and\n> anticipation about Compaq\'s momentum - I see it in the emails from many of\n> you and as I meet with our teams and customers around the world.  You\'re a\n> remarkable team and, as Michael puts it, let\'s keep the pedal to the metal\n> and keep the momentum strong as we work to successfully close 2000!\n>\n> Speaking of my travels...\n> This month I visited Johannesburg, South Africa, Dubai within the United\n> Arab Emirates, and Saudi Arabia.  All of these countries are part of\n> EMEA\'s Business Development Group (BDG), which is responsible for\n> developing Compaq business in 98 countries. The group is focused on both\n> developed and emerging markets in Eastern Europe, the Middle East and\n> Africa. Over the past six years, BDG has grown its revenue more than\n> 10-fold.\n>\n> In South Africa I visited Vodacom, which with 4 million subscribers, is\n> Africa\'s largest mobile phone network operator.  The company has just\n> upgraded its billing systems to handle further expansion, and to date is\n> one of the world\'s largest Wildfire installations with some 21 AlphaServer\n> GS systems.  I also spent time with the management of Mobile Telephone\n> Networks (MTN), South Africa\'s #2 cellphone operator and another big\n> Wildfire customer.  In fact, we just got word that they\'ve placed a $10M\n> order for four GS320 AlphaServer systems and storage.\n>\n> One of my more interesting activities while there was learning more about\n> Ikageng, a Compaq-led initiative to bring the benefits of the information\n> age to the rural communities of Africa.  Ikageng brings together the\n> provision of safe drinking water, affordable healthcare, distance\n> learning, improved subsistence farming techniques and Internet access.\n> All of this is co-funded by a community bank, together with Compaq,\n> Johnnic, a South African media and information group, and the active\n> participation of the World Bank.  A real example of Inspiration Technology\n> at work!\n>\n> My visit to the United Arab Emirates included a dinner with our top 30\n> customers from across the region, a VIP lunch with our top partners, as\n> well as meetings with employees in the region.  I also attended Gitex, the\n> region\'s largest IT exhibition, and met with press at that event to convey\n> Compaq\'s commitment to the UAE.  I was also privileged to have a personal\n> meeting with His Highness Sheik Mohamad bin Rashid al Maktoum, Crown\n> Prince of Dubai and the Minister of Defense.  These meetings were around\n> the official opening of Dubai Internet City, an area of Dubai dedicated to\n> making the city the "Silicon Valley"  of the Middle East.\n>\n> I spent a very interesting day at Aramco in Saudi Arabia, our largest\n> account in the UAE. We are the ProLiant standard in this very large energy\n> company and we have a great opportnuity to build a strong partnership\n> across many additional solutions including high performance technical\n> computing, ZLE applications and enterprise storage, in addition to\n> recapturing client business from the competition\n>\n> Some of our largest wins this month\n> * Tokyo Stock Exchange - We are replacing Hitachi at the world\'s third\n> largest stock exchange, with a $60-80M order for Himalaya systems. This\n> contract should bring in an additional $20-30M in Professional Services.\n> *      Eli Lilly - Signed the first leg of a three-year global agreement\n> valued at $100M, securing Compaq as the sole supplier for Intel-based\n> products, forcing Dell off the customer\'s standards list and opening the\n> door for StorageWorks products, Global Services and high-performance\n> servers.\n> *      Winstar - Four-year, $100M contract as the exclusive provider of\n> Windows NT and storage products, including $10M in AlphaServer systems\n> running Tru64 UNIX.\n> *      Mead Corp. - Beat IBM, HP and Dell for a five-year, $50M contract\n> for ProLiant servers, storage, desktops, portables and services.\n> * France Telecom - $30M contract for a global agreement (includes all\n> subsidiaries) for a complete line of AlphaServer systems, including DS, ES\n> and GS series as well as ProLiant servers.\n> * General Motors - Selected as the global Intel-based server standard\n> for new application deployment at GM manufacturing facilities. The\n> anticipated global revenue is $30M over three years.\n> * Electronic Classroom of Tomorrow - $25M for ProLiant 8500 servers,\n> StorageWorks products and legacy-free iPAQ desktops.\n> * FleetBoston Financial - Beat IBM, Dell and HP for a $40M desktops\n> contract\n> * Airgroup (Switzerland) - Beat IBM and NetVista for a  $21M contract\n> for 20,000 iPAQ desktops.\n> * DLI (Korea) - $22M for Professional Services.\n> * AltaVista - Shut out IBM and HP by putting into place a $25M fair\n> market value lease for ProLiant- and Alpha-based servers, increasing the\n> AltaVista lease line to $75M.\n> * ASP Host Centric - One of the eight North America-certified Oracle\n> Authorized Application Providers (OAAP), the firm will standardize its\n> UNIX environment on AlphaServers, replacing Sun systems. This project\n> could generate more than $20M for us over the next 36 months.\n> * Interfusion - Three-year, $20M contract for a Tru64 UNIX-based\n> solution.\n> * Westcoast Energy- Topped Dell for a desktop and portables contract\n> valued between $15-20M.\n> * General Electric - Five-year, $15.4M contract for worldwide Lotus\n> Domino rollout and expansion of Exchange rollout, including NT Server\n> management outsourcing.\n> http://newscpq1.inline.cpqcorp.net/article.cfm?storyid=1146\n> * Moebel Pfister - $15.7M outsourcing contract.\n> * TriRiga - Beat Dell, EMC and Sun for a two-year, $15M contract for\n> storage, Professional Workstations, desktops, portables and services.\n>\n> EMEA to open Wireless Competence Centre in Stockholm\n> Press, customers and partners have been invited to help officially open\n> the Compaq Wireless Competence Centre in Stockholm, Sweden, on November\n> 27.  The centre is the company\'s first facility to fully display our\n> unique end-to-end capabilities of  solutions, services and products in the\n> mobile Internet and wireless space.  The hands-on centre showcases today\'s\n> wireless solutions within four environments - car, home, office and public\n> access areas.  Technologies featured include GSM, GPRS, future 3G\n> standards, WLAN and Bluetooth.  Compaq\'s mobile partners such as Nokia,\n> Oracle, Cisco, Microsoft, Siebel and Ericsson also plan to participate in\n> the opening.  The centre is already hosting customer visits and will\n> engage with thousands of customer and partners over the coming year\n> through a mix of seminars, tours and customized workshops.  For more info,\n> see  http://inline-se.soo.cpqcorp.net/wireless/\n>\n> Planning for Innovate Forum 2001 under way\n> Compaq\'s premier event for its global and large account customers -\n> Innovate Forum 2001 - is set for May 23-24 at the George R. Brown\n> Convention Center in Houston.  The hand-picked guest list will include\n> some 4,000-5,000 senior-level technical and business executives, including\n> our key channel partners, press, industry and financial analysts, and\n> Compaq\'s key alliance partners.  The program will feature keynote\n> speeches, plenary sessions, special interest seminars, a solutions\n> pavilion, and social events.  For more information, see the Innovate site\n> on Inline:  http://inline.compaq.com/na/innovate/\n>\n> Cross Border Office files first lawsuit\n> The Cross Border Office has been created to prevent unauthorized movement\n> of Compaq products by dealers and gray market brokers in order to protect\n> profit margins and ultimately, customer satisfaction.  The Cross Border\n> team provides gray market awareness training to all sales personnel, mail\n> and phone hotline access to report gray market activity, works jointly\n> with regional sales, services, business unit and channel teams to create\n> policy and procedures to reduce gray market activity and, working with the\n> Law department, to bring legal action against gray market brokers if\n> warranted.\n>\n> As a result of these efforts, Compaq has filed its first lawsuit against\n> two Canadian technology consulting firms for breach of contract and fraud.\n> The suit, which seeks compensatory damages of more than $17 million,\n> claims the consulting firms fraudulently represented to Compaq that they\n> had a contract with the U.S. Department of Transportation\'s Federal\n> Aviation Administration to supply a large number of computers and related\n> equipment to U.S. airports. This lawsuit hit many national publications\n> and sends a message to the worldwide gray market community that Compaq\n> will take actions to protect its authorized resellers, product quality and\n> our customers.\n>\n> For further information on the Cross Border Office, gray market red flags\n> and to view the web-based training video, see\n> http://inline.compaq.com/wwsm/crossborder/index.asp\n>\n> Key Channel Partner programs rolling out\n> Early this year the Tigerbite project was established to redefine and\n> simplify Compaq\'s model with our channel partners.  A key element of the\n> model is worldwide programs that provide profitable growth opportunities\n> for Compaq and its partners.  Two such programs - Internet List Pricing\n> (ILP) and the Compaq Agent Program - are currently being implemented by\n> the regions.\n>\n> Worldwide implementation of ILP is a top priority for the company.\n> Creating and publishing (where needed) competitive List Prices is\n> absolutely essential to establishing a more consistent, worldwide pricing\n> model for both our customers and partners. By the end of this month ILP\n> will have been implemented in North America, Latin America, Japan and\n> Greater China, with pilot programs in Singapore and Malaysia.  EMEA and\n> the remaining Asia Pacific countries are expected to complete the rollout\n> by January 1, 2001.\n>\n> The Compaq Agent Program, which allows partners to earn commissions when\n> they refer customers to purchase products/services directly from us,\n> currently has been implemented in the U.S., Latin America (14 countries)\n> and CKK.  This month, APD is implementing pilot programs in Singapore and\n> Malaysia, and plans to roll out the program in seven additional countries\n> in the first quarter.  EMEA held an Agent Program Summit this month with\n> 10 countries to assess and develop their 2001 rollout plans which include\n> adding Enterprise-class products to their program next year.\n>\n> News from the Compaq Alliances team\n> *      Compaq regained the #1 platform partner position with SAP with 33%\n> market share over all platforms (NT, UNIX with R/3, and mySAP.com). IBM is\n> 2nd in line with 23% share. In North America alone, our overall SAP share\n> increased from 25% to 32% in the third quarter.  As an aside, SAP\'s entire\n> executive board and senior executive staff use our iPAQ Pocket PCs.\n> Rollout of the product to SAP Sales and Marketing is also in progress -- a\n> very visible endorsement of Compaq\'s leadership in Internet access as it\n> applies to enterprise applications.\n> * Cable & Wireless CEO and executive visit to Marlboro in October\n> included CEO Graham Wallace and 56 top C&W executives. C&W new ASP\n> \'a-Services\' UK launch on October 31 followed the successful U.S. launch\n> in late September.\n> * Compaq secured the notebook business with CGE&Y UK for their\n> internal use.  Toshiba had been the incumbent for 5 years.  CGE&Y is\n> upgrading to Oracle 11i on Alpha Tru64 UNIX.  As one of the first\n> customers globally to upgrade to 11i on Alpha, they have agreed to be a\n> reference site.\n> * Our successful Platinum Sponsorship of Commerce One\'s Global Trading\n> Web Technical Forum included a Compaq keynote and non-disclosure breakout\n> session on new ProLiant 8-ways.\n> * A  9-city roadshow in EMEA was kicked-off with Intel, starting in\n> Munich.  This is an extension of the successful 11 city roadshow in the\n> U.S. that drove traffic to the speedStart website and should do the same\n> for EMEA..\n> * Strong Compaq presence with Premier sponsorship at Oracle Open World\n> in October included Michael Capellas luncheon speech to 200+ C-level\n> customers, on-stage server presence at Larry Ellison keynote, and\n> excellent Compaq coverage in Oracle publications.\n> * Announced major Mid-Market Initiative Contract with Siebel.  We had\n> very high visibility at Siebel User Week, and also won Siebel\'s Platform\n> Partner of the Year awards for Excellence in EMEA and NA.  We recently\n> announced a Benchmark Figure of 10,200 Siebel users running Microsoft NT\n> and SQL 7 on ProLiant systems.\n> * Compaq had a strong presence at COMDEX with strategic partner,\n> Microsoft.  In addition to  supporting Bill Gates\' keynote address, the\n> Microsoft booth featured iPAQ Pocket PCs demonstrating the award-winning\n> OmniSky wireless Internet and e-mail service running on Metricom\'s\n> Ricochet network - the world\'s fastest mobile broadband network.\n> Microsoft also announced the immediate availability of its Windows Media\n> Player Technology Preview Edition on Compaq Pocket PCX devices, which for\n> the first time delivers streamed wireless Windows Media-formatted audio\n> and video to a portable device.\n>\n> Global Accounts news\n> * Do you know about the Discovery, Design and Implementation (DDI)\n> application? Global Accounts has moved the DDI application into\n> production, resulting in a Web-enabled tool that streamlines and automates\n> the DDI phases for signing up new customers.\n> http://vinproapp03.cce.cpqcorp.net/ddi/\n> * More than 130 people from Compaq EMEA Global Accounts attended a\n> conference center at EuroDisney, Paris, for a training program that\n> included a focus on personal development skills and a broader look at how\n> Global Accounts can build sales.\n\n> * A CD and brochure designed to give Global Accounts salespeople and\n> customers a greater insight into the business can be ordered online\n> through the GA catalog.\n> http://inline.compaq.com/corpmktg/globalaccounts/know/resourcekit.asp\n> * For the first time, Compaq has a single, documented global special\n> pricing process, enabling us to be smarter than the competition on global\n> bids.  Implementation of this process is expected to begin January 1. For\n> more information, see\n> http://inline.compaq.com/corpmktg/globalaccounts/div/stratplan/index.asp\n> or e-mail Philip Kyle.\n> * Global Account managers and others whose customers and prospects\n> require multi-platform hardware, operating systems and applications will\n> want to know about the IQ Center. With more than 150 systems engineering\n> personnel, 30,000 square-feet of lab space, 500 CPUs and 100 TB of\n> storage, the Center is a well-equipped, one-stop shop for designing and\n> testing complex solutions.\n> http://inline.compaq.com/corpmktg/globalaccounts/div/gamclose.asp\n>\n> CPCG headlines\n> * Compaq regained total PC and PC server market share leadership in\n> the UK during 3Q.\n> * Among our many announcements at Comdex, we introduced the\n> three-pound, MP2800 - the world\'s smallest projector -- as well as\n> iPAQnet, a collection of products and solutions designed to redefine the\n> Internet experience for customers demanding wireless access to e-mail and\n> other corporate information. Last, Compaq and Oracle announced an all-new\n> Internet appliance based on ProLiant servers and the latest Oracle\n> software to deliver the fastest cache on the Internet. Oracle is backing\n> up the performance pledge with a $1 million guarantee.\n>\n> Ratings and reviews\n> * Computer Shopper named the iPAQ Pocket PC one of the "Top 100\n> Products of 2000"\n> * "Looking for the perfect present for the technophile who has\n> everything? Then check out the Compaq iPAQ Pocket PC ... the iPAQ is a lot\n> slimmer than most of the competition ... Plus, its brilliant 12-bit,\n> 4,096-color reflective display will be sure to make the holiday season\n> especially bright." - ZDNet\n> * Popular Science recognized the iPAQ Pocket PC at an awards ceremony\n> for being one of the year\'s 100 "hottest products and eye-opening\n> discoveries." The iPAQ Pocket PC is pictured on the cover of the\n> magazine\'s December edition, now on newsstands.\n> * "Sure, the Compaq iPAQ Pocket PC PDA has everything a desktop PC has\n> - word processor, Internet browser, e-mail engine, etc., etc. But that\'s\n> not even half the story: It can crank out color video and blast MP3 music\n> through a stereo headphone jack..." - Stuff Magazine\n>\n> Portables garner praise\n> * The Armada E500S received the "Four-Star Award" from Computer\n> Shopper. "Overall, the Armada E500S is a compelling, well-designed package\n> for small businesses ... you get a solid mix of components for the money."\n> - Computer Shopper\n> * The Notebook 100 was named one of the Top 100 Products of the Year\n> by Computer Shopper. "We were duly impressed with Compaq\'s price-defying\n> Notebook 100."\n>\n>\n> Consumer Group highlights\n> * Last month, we shipped our 500,000th Configure-to-Order unit. U.S.\n> CTO sales grew 256% in the third quarter.\n> * Worldwide beyond-the-box revenue in Q3 increased 90% year-over-year.\n> * Of the top 25 countries with the highest Consumer sales worldwide,\n> six are in the Latin America region: Mexico (2), Brazil (4), Argentina\n> (8), Chile (16), Peru/Bolivia (21) and Colombia (22).\n> * Consumer\'s EMEA region hit the $1 billion sales mark in mid-October,\n> two months earlier than in 1999.\n> * More than 50,000 DSL-ready Presario computers have been sold through\n> our deal with Southwestern Bell.\n> http://newscpq1.inline.cpqcorp.net/article.cfm?storyid=1034\n> * Popular Science magazine included the iPAQ Home Internet Appliance\n> in its "Best of What\'s New" in the computer and software category.\n>\n> Storage Product Group news\n> *      Compaq Belgium and Luxembourg have won four DATANEWS Awards for\n> Excellence, one of which was in the category of Enterprise Storage: Compaq\n> StorageWorks systems. Compaq also received Awards of Excellence for\n> Enterprise Server (ProLiant); High-End Workstations (Compaq Professional\n> Workstation), and Services. The Compaq Aero Professional Digital Assistant\n> (PDA) received a Quality Award. For more info, visit:\n> http://datanews.vnunet.be/dnafe0.asp\n> *      An elite group of storage networking companies has joined our\n> commitment to support VersaStor Technology - the industry\'s premier\n> implementation of networked storage pooling. These endorsements represent\n> an important milestone in enabling SAN customers to leverage business\n> information as a virtual resource.\n> http://www.compaq.com/newsroom/pr/2000/pr2000103002.html\n> * Construction has begun on the Storage Networking Industry\n> Association Technology Center (SNIA Technology Center) in Colorado\n> Springs, Colo. Upon completion, the 14,000-square-foot center will be the\n> largest independent storage networking lab in the world.\n> http://storage.inet.cpqcorp.net/download/doc/SNIA_Release_final.doc\n> * At last month\'s Storage Networking World conference, Compaq and IBM\n> demonstrated for the first time true multi-vendor online storage\n> interoperability for the Open SAN Earlier this month we announced three\n> new storage service offerings that accelerate SAN implementation, improve\n> enterprise backup performance and increase availability and reliability of\n> remote storage management.\n> http://www.compaq.com/newsroom/pr/2000/pr2000103001.html\n>\n> Business Critical Server Group highlights\n> * Our Tru64 UNIX business is gaining momentum - growing twice as fast\n> as the market in Q2 and Q3 of this year, according to International Data\n> Corp. IDC reports that Compaq was the fastest growing UNIX vendor in Q2,\n> with 25% growth versus overall UNIX market growth of 13%.\n> * On Oct. 31, we announced new Tru64 UNIX, TruCluster and AlphaServer\n> products and services enhancements to improve scalability and ease of\n> deployment for e-business solutions.\n> http://alphaserver.inet.cpqcorp.net/announcements/30oct00/index.html\n> * The International Tandem Users\' Group (ITUG) Summit 2000, held Oct.\n> 15-19 in San Jose, Calif., was the largest ever, drawing 2,900 customers,\n> partners, internal developers and executives. A highlight of the general\n> session was a live demonstration of the Zero Latency Enterprise\n> architecture for customer relationship management, which brings together\n> Himalaya, AlphaServer and ProLiant platforms.\n>\n> North America eBusiness Solutions successes\n> *      Service Provider Winstar has signed Compaq as its exclusive\n> provider of NT and storage products and committed to purchase a minimum of\n> $100M of Compaq products over the next four years, $10M of which will be\n> for Alpha UNIX for their rapidly growing complex hosting business.  We\'re\n> also providing $50M in financing directly to Winstar and $50M in financing\n> to approved Winstar customers.  Compaq Services has been designated as a\n> Winstar Services Partner.\n> *      Exodus placed an initial order of more than 500 ProLiant servers\n> for their Intel-managed hosting platform.\n> * Compaq also inked a deal with Siebel Systems to create a dedicated\n> partner sales channel and a $30M joint marketing initiative for an\n> integrated hardware/software offering to small and medium enterprises.\n> Over 80 sales agents are being authorized to sell the packages, which are\n> delivered fully integrated by Compaq Direct.\n>\n> Compaq Financial Services making a difference\n> *      Compaq Financial Services was instrumental in helping to shut out\n> IBM and HP from long-time Compaq customer AltaVista by putting into place\n> a $25M fair market value lease for NT and AlphaServers.  Through the deal,\n> CFS increased Alta Vista\'s lease line to $75M.\n> * CFS scored its first local currency financing in Brazil with a $3M\n> deal for servers and services.  In awarding the contract over competitors\n> HP and IBM and their respective financing groups, Ericsson cited\n> differentiating factors including Compaq\'s technology and our ability to\n> provide a competitive price in local currency.  CFS invoicing\n> capabilities, including information for each separate Ericsson cost center\n> in Brazil, was also a deciding factor.\n> * CFS helped facilitate the largest delivery of Intel servers\n> (ProLiant ML 370) to the Czech Republic through a $2.8M, 3-year operating\n> lease transaction with Czech Savings Bank.  CFS was the only leasing\n> company to offer a sub-lease structure, a differentiating factor that won\n> the business over Dell and IBM.\n>\n> CEI changes name to Compaq Direct\n> Custom Edge Inc., a wholly owned Compaq subsidiary formed, is now called\n> Compaq Direct. In other "direct" news, did you know that we have more than\n> 230 major accounts now buying from us directly and more in the pipeline?\n> Combined revenue in Q3 from PartnerDirect, DirectPlus, Major Account\n> Direct and GEM Direct totaled nearly 40 percent of CPCG\'s total revenue in\n> North America. What\'s more, ISSG revenue was more than 27 percent direct\n> in Q3.\n>\n> Siebel\'s Platform Partner of the Year\n> I\'m pleased to report that Siebel has named Compaq its Platform Partner of\n> the Year for excellence in both EMEA and North America. We recently\n> received high visibility at the Siebel User Week event while also\n> announcing a record benchmark of 10,200 Siebel users running Microsoft NT\n> and SQL 7 on ProLiant servers.\n>\n> Get Informed\n> Inform, Compaq\'s customer magazine, is now available in printed and\n> electronic versions. It\'s free and available for you to read. Sign your\n> customers up by visiting the U.S. (www.compaq.com/inform/issues/sb.html),\n> Asia Pacific (www.compaq.com.tw/) or EMEA (www.compaq.com/emea/inform)\n> sites.\n>\n> North America eCommerce and CRM marketing activities\n> * North America recently released IMPAQ express, a Web-based tool for\n> Customer Relationship Management (CRM) campaign planning and audience\n> sizing, to its marketing and sales force. For the first time, campaign\n> planning can start with a quick and easy look at the size and scope of a\n> potential installed-based audience.\n> * Compaq recently co-sponsored eLink, a B2B e-commerce event targeted\n> at procurement, IT, marketing and financial executives hosted by Commerce\n> One in Las Vegas. Attendees witnessed the on-stage construction of a live\n> e-marketplace powered by Commerce One and Compaq servers. In addition, we\n> demonstrated our Roundtrip configuration and Auction capabilities.\n>\n> Wins Around the World\n> As always, thanks to everyone for your tremendous efforts this month.\n> Please take a few minutes to look over the complete list of recent wins\n> around the world and continue to write me with your news and success\n> stories. http://inline.compaq.com/wwss/wins/worldwins.asp\n>\n> Let\'s finish the quarter strongly!!\n>\n> Regards,\n> Peter\n>\n> ', 'mid': '20975411.1075840253448.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/discussion_threads/834.', 'bcc': ['michael.capellas@compaq.com'], 'to': ['babbio@verizon.com', 'lynnj@iname.com', 'ted.enloe@compaq.com', 'ghh@telcordia.com', 'klay@enron.com', 'kjewett@kpcb.com', 'kenroman@worldnet.att.net', 'lucie@jhmedia.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '834.', 'date': '2000-12-05 02:05:00-08:00', 'folder': 'discussion_threads', 'subject': 'November Blackmore Report'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a370'), 'sender': 'djtheroux@independent.org', 'recipients': [], 'cc': [], 'text': 'Tue, 12 Dec 2000 18:49:21 -0600\nDate: Tue, 12 Dec 2000 18:49:21 -0600\nMessage-Id: <200012130049.SAA07799@server1.pjdoland.com>\nTo: klay@enron.com\nFrom: David Theroux <DJTheroux@independent.org>\nReply-to: DJTheroux@independent.org\nX-Mailer: Perl Powered Socket Mailer\nSubject: THE LIGHTHOUSE: December 12, 2000\n\nTHE LIGHTHOUSE\n"Enlightening Ideas for Public Policy..."\nVOL. 2, ISSUE 48\nDecember 12, 2000\n\nWelcome to The Lighthouse, the e-mail newsletter of The Independent \nInstitute, the non-partisan, public policy research organization \n<http://www.independent.org>. We provide you with updates of the Institute\'s \ncurrent research publications, events and media programs.\n\n-------------------------------------------------------------\n\nIN THIS WEEK\'S ISSUE:\n1. Pentagon "Shocked" to Find Rivers Dammed with Pork\n2. The Environmental Propaganda Agency\n3. William Lloyd Garrison, Antislavery Crusader\n\n-------------------------------------------------------------\n\nPENTAGON "SHOCKED" TO FIND RIVERS DAMMED WITH PORK\n\nCaptain Louis Renault -- Claude Raines\'s cheerfully duplicitous character in \nthe 1942 film classic "Casablanca" -- asserted glibly that he was "shocked, \nshocked" to learn that gambling was taking place at Rick\'s Cafe. Moments \nlater he was only too happy to collect his gambling earnings for the night.\n\nAll this is by way of preamble to a new Pentagon investigation of fraud in \nmilitary construction. The investigation concluded that three senior Army \nCorps of Engineers officials had, just as one whistle-blowing Corps economist \nhad claimed, engaged in a deceitful campaign to justify what the Washington \nPost called "a billion-dollar construction binge on the Mississippi and \nIllinois rivers."\n\n"The [Pentagon] investigators concluded that the agency\'s aggressive efforts \nto expand its budget and missions, as well as its eagerness to please its \ncorporate customers and congressional patrons, have helped \'create an \natmosphere where objectivity in its analyses was placed in jeopardy,\'" the \nPost reports.\n\n"Even the agency\'s retired chief economist told them that Corps studies were \noften \'corrupt,\' and that several Corps employees cited \'immense pressure\' to \ngreen-light questionable projects."\n\nBureaucratic boondoggles of such magnitude are certainly newsworthy. But they \nare hardly news. Just as the Soviets derided the failures of previous Five \nYear Plans (only to implement new, equally flawed versions), so it seems that \nevery few years the Pentagon uncovers massive corruption and waste in its own \ncentrally planned fiefdom -- only to present a new Plan that operates under \nthe same bad incentives that encouraged prior malfeasance.\n\nWith corruption and waste seemingly "taken care of," the worst pork-barrel \nspenders in Congress and the military are then let off the hook, only to \nenjoy -- like Casablanca\'s Renault and Rick -- an amicable toast to the \nbeginnings of a beautiful new friendship.\n\nFor the Washington Post series on the Army Corp of Engineers boondoggle, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-1.html.\n\nFor a summary of the Independent Institute book, ARMS, POLITICS AND THE \nECONOMY: Historical and Contemporary Perspectives, edited by Robert Higgs, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-2.html.\n\n-------------------------------------------------------------\n\nTHE ENVIRONMENTAL PROPAGANDA AGENCY\n\nWill the neck-to-neck presidential race help reduce -- or intensify -- \npressure for the next president of the United States to score points with \nstatist environmental activists?\n\nExcept on a few controversial issues, a strong case can be made that the \nforty-third President of the United States will wish to portray himself as a \nclose friend of "the environment." President George W. Bush, for example, \nwould face strong pressure to show that he is "bipartisan" in his approach to \nenvironmental protection; whereas President Al Gore would likely attempt to \nwin back those who supported Nader and the Greens.\n\nAll the more reason, then, to call attention to the failures of the current \napproach to environmental protection -- especially those emanating from the \nU.S. Environmental Protection Agency, or, as economist Craig Marxsen terms \nit, the Environmental Propaganda Agency.\n\nThe EPA sometimes employs the language of cost-benefit analysis to illustrate \nits seemingly tremendous success, but it is known to employ it in a highly \nmisleading manner. The EPA claimed, for example, that its Clean Air Act \nprograms produced, from 1970 to 1990, $22.2 trillion dollars in health \nbenefits at a cost of only $523 billion. But, reports Marxsen in THE \nINDEPENDENT REVIEW, "[The EPA\'s] study actually represents a milestone in \nbureaucratic propaganda. Like junk science in the courtroom, the study \nseemingly attempts to obtain the largest possible benefit figure rather than \nto come as close as possible to the truth."\n\nIn conclusion, writes Marxsen, "Without the illusory benefit of all the lives \nsaved, the actual benefits of the Clean Air Act were very modest and probably \ncould have been achieved nearly as well with far less sacrifice. The Clean \nAir Act and its amendments force the EPA to mandate reduction of air \npollution to levels that would have no adverse health effects on even the \nmost sensitive person in the population. The EPA relentlessly presses forward \nin its absurd quest, like a madman setting fire to his house in an insane \ndetermination to eliminate the last of the insects infesting it."\n\nFor more information, see "The Environmental Propaganda Agency," by Craig S. \nMarxsen (THE INDEPENDENT REVIEW, Summer 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-3.html.\n\nFor analysis of other EPA programs, see the Independent Institute book, \nCUTTING GREEN TAPE: Toxic Pollutants, Environmental Regulation and the Law, \nedited by Richard Stroup and Roger Meiners, at \nhttp://www.independent.org/tii/lighthouse/LHLink2-48-4.html.\n\nFor Robert Formaini\'s insightful review of Kip Viscusi\'s important book, \nRATIONAL RISK POLICY (THE INDEPENDENT REVIEW, Winter 1999), see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-5.html.\n\n-------------------------------------------------------------\n\nWILLIAM LLOYD GARRISON, Antislavery Crusader\n\n"I will be as harsh as truth, and as uncompromising as justice. On this \nsubject, I do not wish to think, or speak, or write with moderation.... I \nwill not equivocate -- I will not excuse -- I will not retreat a single inch \n-- and I will be heard."\n     -- William Lloyd Garrison, THE LIBERATOR, January 1, 1831\n\nDecember 12 marks the 195th anniversary of the birth of William Lloyd \nGarrison, a leading figure in the American abolitionist movement. As the late \nhistorian Henry Mayer explained in his National Book Award-Finalist \nbiography, ALL ON FIRE: William Lloyd Garrison and the Abolition of Slavery:\n\n"William Lloyd Garrison (1805-1879) is an authentic American hero who, with a \nBiblical prophet\'s power and a propagandist\'s skill, forced the nation to \nconfront the most crucial moral issue in its history. For thirty-five years \nhe edited and published a weekly newspaper in Boston, THE LIBERATOR, which \nremains today a sterling and unrivaled example of personal journalism in the \nservice of civic idealism.\n\n"Although Garrison -- a self-made man with a scanty formal education -- \nconsidered himself \'a New England mechanic\' and lived outside the precincts \nof the American intelligentsia, he nonetheless did the hard intellectual work \nof challenging orthodoxy, questioning public policy, and offering a luminous \nvision of a society transformed. He inspired two generations of activists -- \nfemale and male, black and white -- and together they built a social movement \nwhich, like the civil rights movement of our own day, was a collaboration of \nordinary people, stirred by injustice and committed to each other, who \nachieved a social change that conventional wisdom first condemned as wrong \nand then ridiculed as impossible."\n\nIndeed, without Garrison\'s inflammatory but compelling writing, speaking and \norganizing, there might have been no effective American anti-slavery movement \nat all.\n\nFor more on William Lloyd Garrison, read historian Henry Mayer\'s talk from \nthe Independent Policy Forum, "The Civil War: Liberty and American Leviathan" \n(with Jeffrey Rogers Hummel), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-6.html, or hear it in \nRealAudio at http://www.independent.org/tii/lighthouse/LHLink2-48-7.html.\n\nAlso see Jeffrey Rogers Hummel\'s review of Henry Mayer\'s brilliant biography, \nALL ON FIRE: William Lloyd Garrison and the Abolition of Slavery (THE \nINDEPENDENT REVIEW, Fall 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-8.html.\n\n-------------------------------------------------------------\n\nIf you enjoy receiving THE LIGHTHOUSE ... please help us support it.\n\nYour supporting Independent Associate Membership enables us to reach \nthousands of other people. So, please make a contribution to The Independent \nInstitute. See http://www.independent.org/tii/lighthouse/LHLink2-48-9.html. \nto donate, or contact Ms. Priscilla Busch by phone at 510-632-1366 x105, fax \nto 510-568-6040, email to <PBusch@independent.org>, or snail mail to The \nIndependent Institute, 100 Swan Way, Oakland, CA 94621-1428.\nAll contributions are tax-deductible.  Thank you!\n\n-------------------------------------------------------------\n\nFor previous issues of THE LIGHTHOUSE, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-10.html.\n\n-------------------------------------------------------------\n\nFor information on books and other publications from The Independent \nInstitute, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-11.html.\n\n-------------------------------------------------------------\n\nFor information on The Independent Institute\'s Independent Policy Forums, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-12.html.\n\n-------------------------------------------------------------\n\nTo subscribe (or unsubscribe) to The Lighthouse, please go to \nhttp://www.independent.org/subscribe.html, choose "subscribe" (or \n"unsubscribe"), enter your e-mail address and select "Go."\n\nCopyright , 2000 The Independent Institute\n100 Swan Way\nOakland, CA 94621-1428\n(510) 632-1366 phone\n(510) 568-6040 fax\ninfo@independent.org\nhttp://www.independent.org\n', 'mid': '27134356.1075840254595.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/discussion_threads/878.', 'bcc': [], 'to': [], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '878.', 'date': '2000-12-12 10:37:00-08:00', 'folder': 'discussion_threads', 'subject': ''} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a3e6'), 'sender': 'billy.lemmons@enron.com', 'recipients': ['kenneth.lay@enron.com', 'elizabeth.tilney@enron.com'], 'cc': [], 'text': 'Ken,\n\nBeth suggested that I forward a copy of this article to you.  I\'ve highligh=\nted some relevant points for your convenience.\n\nRegards,\nBilly\n\n____________________________________________________________\n\nACCOUNTING IN CRISIS=20\nOne Plus One Makes What?=20\nThe accounting profession had a credibility problem before Enron. Now it ha=\ns a crisis.=20\nFORTUNE\nMonday, January 7, 2002=20\nWhere were the auditors? People ask that question after every corporate col=\nlapse, and lately they\'ve been asking it with disturbing frequency. At Wast=\ne Management, Sunbeam, Rite Aid, Xerox, and Lucent, major accounting firms =\neither missed or ignored serious problems. The number of public companies t=\nhat have corrected or restated earnings since 1998 has doubled to 233, acco=\nrding to a study by Big Five accounting firm Arthur Andersen. Now, followin=\ng the stunning bankruptcy of Andersen\'s own client Enron, that question--wh=\nere were the auditors?--has become a deafening refrain. "I believe that the=\nre is a crisis of confidence in my profession," Andersen CEO Joseph Berardi=\nno told a congressional committee investigating Enron\'s collapse in mid-Dec=\nember. "Real change will be required to regain the public trust."=20\nThe full story of the Enron debacle--and what Andersen did or did not do in=\n its audit--will take months to emerge. In the meantime, no one disagrees w=\nith Berardino\'s diagnosis that there\'s a crisis in accounting--even if his =\nsudden emphasis on industrywide reform springs from a desire to deflect att=\nention from Andersen\'s own culpability. But the kind of "real change" requi=\nred is a matter of substantial debate. The government gave the franchise of=\n auditing public companies\' financial statements to the accounting industry=\n after the 1929 stock market crash. In the decades since, the accountants h=\nave adroitly avoided significant government regulation by arguing that they=\n can police themselves. Now, post-Enron, they\'re doing it again. The Big Fi=\nve CEOs issued a rare joint statement outlining how they intend to strength=\nen financial reporting and auditing standards. "Self-regulation is right fo=\nr investors, the profession, and the financial markets," the release conclu=\ndes.=20\nBut is it? Accounting\'s main self-regulatory body, the Public Oversight Boa=\nrd, is a monument to the profession\'s failures. The POB was created in the =\nlate 1970s, when Congress held hearings on a string of audit failures at pu=\nblic companies that had--much like the recent rash--shaken confidence in th=\ne major auditing firms. The POB, which has no enforcement power, investigat=\nes alleged audit failures and oversees a triennial review process in which =\nthe major accounting firms examine one another\'s procedures. And yet proble=\nms persist; arguably, they have grown more acute. "Is accounting self-regul=\nation working? On the face of it, it is not," says Representative John Ding=\nell, the powerful Michigan Democrat who has long sparred with the accountin=\ng profession.=20\nIn their defense, the auditors note that current accounting methods, many o=\nf which were designed 70 years ago, are difficult to apply to today\'s compl=\nex financial transactions. And there is no way, they insist, to prevent sop=\nhisticated fraud. The American Institute of Certified Public Accountants (A=\nICPA), the industry\'s professional association, points out that accountants=\n examine the books of more than 15,000 public companies every year; they ar=\ne accused of errors in just 0.1% of those audits. But oh, the price of thos=\ne few failures. Lynn Turner, former chief accountant of the Securities and =\nExchange Commission, estimates that investors have lost more than $100 bill=\nion because of financial fraud and the accompanying earnings restatements s=\nince 1995.=20\nPerhaps the most glaring example of self-regulation\'s deficiency has been a=\nccountants\' unwillingness to deal with conflicts of interest. Over the year=\ns, the major auditing firms have transformed themselves into "professional =\nservices" companies that derive an increasing portion of revenues and profi=\nts from consulting: selling computer systems, advising clients on tax shelt=\ners, and evaluating their business strategies. In 1999, according to the SE=\nC, half of the Big Five\'s revenues came from consulting fees, vs. 13% in 19=\n81.=20\nAuditing, meanwhile, has become a commodity. Firms have even been accused o=\nf using it as a loss leader, a way of getting in the door at a company to s=\nell more-profitable consulting contracts. "Audit work is a marvelous market=\ning tool," says Lou Lowenstein, a professor emeritus of finance and law at =\nColumbia University. "You are already there doing the audit. You say their =\ninternal controls are no good. Well, who are they going to call to fix it?"=\n But this requires a firm to work for the public (auditing) and management =\n(consulting). "You cannot serve them both," says former SEC commissioner Be=\nvis Longstreth.=20\nThis conflict may have played a role at Enron. Andersen received $25 millio=\nn in auditing fees from Enron last year. That\'s money Andersen was paid bot=\nh as Enron\'s outside auditor, certifying its financial statements, and as i=\nts internal auditor, making sure Enron had the right systems to keep its bo=\noks and working to detect fraud and irregularities. This double duty alone =\nraised a serious potential for conflict. Besides $25 million in accounting =\nfees, Andersen was paid $23 million for consulting services. "If you are au=\nditing your own creations, it is very difficult to criticize them," says Ro=\nbert Willens, a Lehman Brothers tax expert who disapproves of the accountin=\ng profession\'s recent move into selling aggressive tax shelters. Andersen h=\nas not revealed the details of its work on Enron\'s highly controversial off=\n-balance-sheet transactions, but the accounting firms have never believed c=\nonsulting fees compromise their objectivity. "They have militantly refused =\nto ever acknowledge the possibility of a problem," Longstreth says.', 'mid': '30064053.1075860844222.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/1014.', 'bcc': [], 'to': ['kenneth.lay@enron.com', 'elizabeth.tilney@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '1014.', 'date': '2002-01-10 12:10:39-08:00', 'folder': 'inbox', 'subject': 'Accounting Article From Fortune Magazine'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a4aa'), 'sender': 'wjheilman@worldnet.att.net', 'recipients': ['kenneth.lay@enron.com'], 'cc': [], 'text': "\nI have been an Enron stockholder for several years  and I am very disappoin=\nted with the events of the last two weeks.  I find  the allegations of acco=\nunting irregularities incredible.  I would like to  know how closely the bo=\nard had been monitoring the activities of the CFO and  whether it approved =\nthe partnerships that have led to the SEC investigation and  the dramatic d=\necline in the company's stock price.  I would suggest that  the compensatio=\nn of senior management may be too heavily weighted towards  bonuses (giving=\n some the incentive to manipulate the numbers to increase their  bonuses) a=\nnd not heavily weighted enough towards stock options.  I would  hope in the=\n future the goals of the board and senior management will be aligned  with =\nstockholders (increasing shareholder value).  While I know it is not  reaso=\nn to have expected the stock price to stay in the high 80s, I consider the =\n drop in the last two weeks (apparently as the result of fraud) to be  inex=\ncusable.  I believe the board owes all stockholders an explanation that  wi=\nll finally clear the air about this mess (maybe the markets will trust Enro=\nn  again if it replaces evasion with candor).  Please help return credibili=\nty  and ethics to this company, which apparently are badly needed.\n=20\nWayne Heilman\nOwner of 1,800 Enron shares (in my children's  college fund)\n", 'mid': '28554115.1075862883708.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/1639.', 'bcc': [], 'to': ['kenneth.lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '1639.', 'date': '2001-10-30 23:14:37-08:00', 'folder': 'inbox', 'subject': 'A dissapointed stockholder'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a579'), 'sender': 'wjheilman@worldnet.att.net', 'recipients': ['kenneth.lay@enron.com'], 'cc': [], 'text': "\nI have found the events of the last two months to  be among the most unsett=\nling in my 15 years of owning stock in public  companies.  I have sold my 1=\n,800 shares of Enron Corp. because I no longer  have faith in the board to =\nbe a good watchdog for the best interests  of the shareholders.  I just don=\n't understand how senior managers can  manipulate the financial results of =\nthe company for the past five years and only  recently be discovered.  I ex=\npect the board to act as more than a lap-dog  for senior management.  I am =\nencouraged you turned down the chance to  accept a $60 million payday for t=\nhis merger that salvages what little  shareholder value remains in Enron.  =\nI would expect the board to seek  repayment of any and all bonuses paid to =\nsenior managers based on these  inaccurate financial results, including the=\n estimated $30 million paid to the  CFO, who allegedly is the architect of =\nthis scheme to defraud  stockholders.  Had I known the company was apparent=\nly built on smoke and  mirrors, I would have sold my stock long ago and not=\n be forced  to watch my  children's college fund be pocketed by executives =\nwho have little regard for the  stockholders they were hired to serve.  I g=\nuess the only lesson I can take  from this is that no company, no matter ho=\nw large or prestigious is safe from  dishonest management.  I do not includ=\ne you in this group, but I do believe  you and the board bear some blame fo=\nr allowing this happen for the past five  years.\n=20\nWayne Heilman\nFormer Enron Stockholder\n", 'mid': '15094717.1075862888597.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/1829.', 'bcc': [], 'to': ['kenneth.lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '1829.', 'date': '2001-11-13 22:59:53-08:00', 'folder': 'inbox', 'subject': 'Upset stockholder'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a633'), 'sender': 'jeffrey_fountain@bankone.com', 'recipients': ['kenneth_lay@enron.com', 'ken_lay@enron.com', 'k_lay@enron.com'], 'cc': [], 'text': "Ken,\n\nThanks for having the call yesterday.  I am a believer in Enron and we are\nbuying your debt.\n\nHere's short feedback on the call.  I give the call a B-/C+ grade.  If you\nwant a good example of a company call listen to the tougher calls So Cal Ed\nhad for investors.  They talked with investors twice weekly for months.\nThere is an honestness and openness about the calls that worked to keep\ninvestors informed.\n\nThe angry exchange with the short seller was a blunder.  No matter what the\nquestion, no matter how stupid or obnoxious, the Enron answer should always\nbe empathetic and pointedly factual.  Yes, you will have to open the kimono\nmore than Enron ever has to restore confidence.\n\nENE has become more a financial institution, and less an energy company\nwith hard assets.  You are in a confidence game pure and simple.  Any\nattempt at keeping things close to the vest will backfire and exacerbate\nthe current crisis.  If you want to see disclosure in financials, look at\nCiti's...\n\nENE is having an encounter session with the entire investment community.\nThis is not a time to be aggressive and smart.  It is a time to be open,\nhonest and self-effacing.\n\nThird party confirmation will go a long way in restoring confidence which\nmeans 1) Moody's maintains their rating or limits the change to a one-notch\ndowngrade (bond rating) with stable outlook restored (the Moody's analyst\nis pissed you surprised with the write-off), 2) the SEC gives ENE a fairly\nclean report (no self-dealing found) on their transactions with private\nequity partnerships, 3) no more large surprise write-offs, 4) outside\nauditors continue with unqualified audit reports, 5) operating earnings\ntargets are met for this year and next, and 6)fuller disclosure is made in\nquarterly releases.\n\nOf course, if any fraud or malfeasance is found, you guys and ENE are\nhistory.\n\nI have my ass on the line because I believe in ENE.  We have made\ninvestments.  ENE is in the shitter because of ENE's past communication and\nbehavior mistakes.  Be humble, be smart, and change.\n\nGood Luck!\n\nJeff\n\nP.S.  You state there is a Chinese wall between LJM and ENE.  Why in the\nworld then would you have the same guy, Fastow, play key controlling roles\nin both organizations?  If you want to pay him, pay him.  Keep it simple.\n\nI am glad Skilling is gone.  I wouldn't touch your company's debt while he\nwas there.  I hated him and his attitude?.and my past exposure to him was\nextremely limited.\n\n\n\n\n\nThis transmission may contain information that is privileged, confidential and/or exempt from disclosure under applicable law. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information contained herein (including any reliance thereon) is STRICTLY PROHIBITED. If you received this transmission in error, please immediately contact the sender and destroy the material in its entirety, whether in electronic or hard copy format. Thank you.", 'mid': '25583328.1075852805086.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/296.', 'bcc': [], 'to': ['kenneth_lay@enron.com', 'ken_lay@enron.com', 'k_lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '296.', 'date': '2001-10-24 05:44:16-07:00', 'folder': 'inbox', 'subject': "Yesterday's Call: Feedback"} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a66f'), 'sender': 'jim.schwieger@enron.com', 'recipients': ['kenneth.lay@enron.com', 'boardroom@enron.com'], 'cc': [], 'text': 'For the first time in 22 years of service for Enron I\'m ashamed to admit th=\nat I work for Enron!  I have lost all respect for Enron Senior Management a=\nnd agree with the Financial Analyst when they say that Enron Senior Managem=\nent can not be trusted.  Ethics and Morals are either something everyone el=\nse needs to have except Senior Management or somewhere along the way Senior=\n Management started believing the end justifies the means.  The communicati=\non the Employee\'s have received over the last few years about values such a=\ns Respect, Integrity, Communication and excellence must be propaganda inten=\nded to get Employee\'s to believe Senior Management really supported these v=\nalues so that no one would really notice that their actions represented som=\nething just the opposite.\n\nI can not believe that Senior Management lacks the understanding of human n=\nature to totally ignore the fact that if someone does not trust what you ha=\nve said in the past you should not try and conceal pertinent information in=\n the future.  Then to allow an Enron Spokesperson to speak for Enron with t=\nhe statement "It\'s just a balance-sheet issue"  implies to me that this ind=\nividual does not know what a Balance Sheet or Income Statement is and certa=\ninly should not be speaking to the public.  If you are going to play the ga=\nme of lying, cheating and stealing at least be intelligent enough to presen=\nt a plausible story.  To use phrases such as it was a hedge against fluctua=\nting values in some of Enron\'s broadband telecommunications and other techn=\nology investments is a complete insult to my intelligence and to the defini=\ntion of the word "HEDGE".  A hedge by definition implies that the upside an=\nd downside exposure has been limited.  It frightens me that we are out aski=\nng customers to let Enron help them "HEDGE" their risk when I\'m not sure En=\nron\'s Senior Management understands what a hedge means?\n\nI\'m also confused as to the personal financial involvement of Andy Fastow i=\nn the investment vehicle that generated this write down.  I must be confuse=\nd in that as a Trader Enron has asked me to sign documents declaring that I=\n will not have any personal financial involvement in anything involving the=\n Natural Gas Business.  This must be an example of as my father used to say=\n " do as I say not as I do"? I guess we need to have audits performed of Se=\nnior Managements financial interest to insure their actions are as good as =\ntheir word?\n\nThe fact that Senior Management and the ENE Board of Directors knew these t=\nransactions were being used to manipulate earnings and the stock price and =\ntook advantage of that knowledge to sell their ENE stock options in my opin=\nion is "CRIMINAL".  It provides me no comfort to know that the biggest perp=\netrators of this fraud have left Enron in recent months.  These individuals=\n have stolen billions of dollars from ENE stockholders and Employees and ne=\ned to pay the price for such fraudulent activity.  They are set for life, h=\naving all the money they could ever need, while Employees and Stockholders =\nhave lost their life savings.  You have completely failed at the job you we=\nre hired to perform.  If this type of activity would have occurred farther =\ndown the organization no one would hesitate to fire the individuals involve=\nd and to institute criminal charges.  =20\n\nI for one can not wait until the All Employee meeting next week.  I do not =\nthink anyone wants to hear about third quarter results because how could we=\n trust what is said anyway.  Instead I feel you owe the ENE Employee\'s a th=\norough explanation of how you failed to perform your responsibilities, what=\n actions are going to be taken and most of all apologize for the job perfor=\nmance to date.=20\n\n\n\n', 'mid': '836447.1075852806526.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/350.', 'bcc': [], 'to': ['kenneth.lay@enron.com', 'boardroom@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '350.', 'date': '2001-10-19 11:02:44-07:00', 'folder': 'inbox', 'subject': 'Financial Disclosure of $1.2 Billion Equity Adjustment'} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a6b1'), 'sender': 'karen.denne@enron.com', 'recipients': ['steven.kean@enron.com', 'mark.palmer@enron.com', 'richard.shapiro@enron.com', 'james.steffes@enron.com', 'jeff.dasovich@enron.com', 'susan.mara@enron.com', 'sandra.mccubbin@enron.com', 'kenneth.lay@enron.com'], 'cc': [], 'text': 'FYI, the only people who knew who we invited to the meeting (but did not attend) were Dick Riordan and Kevin Sharer...\n\n\nSaturday, May 26, 2001 (SF Chronicle)\nEnron\'s secret bid to save deregulation/PRIVATE MEETING: Chairman pitches his plan to prominent Californians\nChristian Berthelsen, Scott Winokur, Chronicle Staff Writers\n\n\n   Energy executive Kenneth Lay, head of powerful Enron Corp., quietly\ncourted Arnold Schwarzenegger, Richard Riordan, Michael Milken and other\nluminaries this week in Beverly Hills to drum up support for his solution\nto California\'s energy crisis.\n   His prescription called for more rate increases, an end to state and\nfederal investigations and less rather than more regulation.\n   Lay, a close friend of President Bush and one of his largest campaign\ncontributors, hosted a private 90-minute meeting in a conference room at\nthe Peninsula Hotel in Beverly Hills on Thursday.\n   Among the participants were Milken, the former head of the Drexel Burnham\nLambert investment banking firm who pleaded guilty to fraud charges in\n1990 and who now runs a think tank based in Santa Monica; movie star\nSchwarzenegger;\n   and Riordan, the mayor of Los Angeles. Schwarzenegger and Riordan have\nbeen courted recently as GOP gubernatorial candidates.\n   One participant, who agreed to speak on the condition he not be\nidentified, said the meeting appeared to be geared toward getting\nparticipants to support Lay\'s vision and then champion it to officials who\nare trying to solve the state\'s energy mess.\n   PLAN TO RESCUE DEREGULATION\n   The source said the timing and tone of the meeting suggested Lay is\nconcerned that California will abandon its disastrous experiment with\npower markets by either re-regulating the system or creating a government\nauthority to provide electricity. Gov. Gray Davis signed legislation last\nweek to create and fund a state power authority that would build, buy and\nrun power plants in California.\n   "They\'re trying to rescue deregulation," the source said of Enron\nexecutives. "They think the whole state power authority is a bad idea."\n   At the meeting, Enron representatives circulated a four-page position\npaper titled "Comprehensive Solution for California," which was obtained\nby The Chronicle. It said ratepayers should bear responsibility for the\nbillions in debt incurred by the state\'s public utilities and that\ninvestigations of power price manipulation and political rhetoric are\nmaking matters worse.\n   The paper made no mention of the possibility that much of the runaway\nelectricity costs in California is due to market manipulation by power\ngenerators and traders -- a possibility given credibility in studies by\nregulators and economists.\n   One of the talking points read: "Get deregulation right this time --\nCalifornia needs a real electricity market, not government takeovers."\nAnother point suggested giving consumers monetary rebates for conserving\nelectricity.\n   INVOLVED IN EARLY DAYS\n   Lay has been an aggressive champion of deregulated electricity markets and\nwas an early advocate in persuading California to begin its experiment\nwith a competitive power market system.\n   Lay has created a new kind of company in the process, one that essentially\nproduces nothing but makes money as a middle-man, buying electricity from\ngenerators and selling it to consumers. During the first quarter of this\nyear, Enron\'s revenues increased 281 percent to $50.1 billion.\n   Asked about the purpose of the meeting, Karen Denne, a spokeswoman for\nEnron, said she would "look into that" and then did not return repeated\ntelephone calls seeking comment. One participant said Denne was present at\nthe meeting.\n   D.C. CONNECTIONS\n   Meanwhile, Lay\'s power in Washington is reported to have reached\nunprecedented heights. According to a story in yesterday\'s New York Times,\nLay supplied the Bush administration with a list of candidates for jobs\nregulating the power industry and even interviewed one of them. The story\nalso said Lay essentially threatened to seek the removal of the chairman\nof the Federal Energy Regulatory Commission, Curt Hebert, if he does not\nsupport Lay\'s desire to further deregulate the nation\'s electricity\nsystem. Lay denied the allegation.\n   Also in attendance at this week\'s meeting were Bruce Karatz, chief\nexecutive of home builder Kaufman & Broad; Ray Irani, chief executive of\nOccidental Petroleum; and Kevin Sharer, chief executive of biotech giant\nAmgen.\n   Among those who were invited but did not attend were former Los Angeles\nLakers star Earvin "Magic" Johnson; supermarket magnate and Bill Clinton\nsupporter Ron Burkle; and Dennis Tito, recently returned from the world\'s\nfirst civilian space trip.\n   Milken, through a spokesman, confirmed that he attended the meeting, but\ndeclined to be interviewed. Schwarzenegger could not be reached for\ncomment through a publicist, and Sharer did not return a call yesterday\nafternoon.\n   A spokesman for Riordan, Peter Hidalgo, said the Los Angeles mayor\nattended,\n   but was "not intending to formulate any kind of policy position on this\nissue.\n   His intent is to listen to all sides."\n   Attached to the Enron handout was a two-page open letter, addressed to\nDavis and the state Legislature, apparently prepared for those who support\nLay\'s position and would be willing to sign their names to it. The source\nwho participated in the meeting said those assembled appeared noncommittal\nand asked a number of questions of Lay, but did not agree to champion his\nagenda.\n   E-mail the writers at cberthelsen@sfchronicle.com and Scott Winokur at\nswinokur@sfchronicle.com.\n----------------------------------------------------------------------\nCopyright 2001 SF Chronicle\n', 'mid': '1717743.1075845190749.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/41.', 'bcc': [], 'to': ['steven.kean@enron.com', 'mark.palmer@enron.com', 'richard.shapiro@enron.com', 'james.steffes@enron.com', 'jeff.dasovich@enron.com', 'susan.mara@enron.com', 'sandra.mccubbin@enron.com', 'kenneth.lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '41.', 'date': '2001-05-26 07:47:25-07:00', 'folder': 'inbox', 'subject': "SF Gate: Enron's secret bid to save deregulation/PRIVATE MEETING:\r\n Chairman pitches his plan to prominent Californians"} 
    
    {'_id': ObjectId('52af48b6d55148fa0c19a757'), 'sender': 'wade.cline@enron.com', 'recipients': ['kenneth.lay@enron.com', 'stanley.horton@enron.com', 'a..hughes@enron.com', 'stanley.horton@enron.com', 'a..hughes@enron.com'], 'cc': ['stanley.horton@enron.com', 'a..hughes@enron.com'], 'text': 'Ken,\n\nI wanted to update you on the reaction to your most recent letter to the In=\ndian Prime Minister. You recall that we recommended you write again to the =\nPrime Minister and express disappointment at the lack of progress since you=\nr July trip and your August letter containing our offer to sell our equity =\nat costs. I believe writing this letter was the proper response but only ti=\nme will tell what reaction (if any) finally comes from the Indian governmen=\nt.\n\nI think you should know about the press coverage of the letter, just in cas=\ne the letter were to come up in any conversation you might have with someon=\ne from the US government. I am not anticipating this at all, but I would no=\nt want you to be unprepared about the press coverage. The US embassy over h=\nere is very much up to speed.  I met again with Ambassador Blackwill on Tue=\nsday of this week and gave him a general update on the current status. His =\nview is that it is very difficult in the post-Sept. 11 environment to get a=\nnyone in Delhi or Washington to pay attention to economic matters such as D=\nabhol, but he is trying as best he can. He is meeting with Brajesh Mishra (=\nPrime Minister\'s principal secretary) on Saturday, who will have just retur=\nned from Washington meetings with Ms. Rice, among others, principally to di=\nscuss anti-terrorist matters. John Hardy of our DC office briefed the State=\n Department last week in advance of these meetings, and we are awaiting to =\nhear any discussion or outcome regarding Dabhol.\n\nRegarding press coverage of the letter, as we anticipated, the entire lette=\nr was leaked to the press. Several articles have appeared that describe the=\n "harshly worded" letter and many articles have quoted verbatim sections fr=\nom the letter. The Wall Street Journal article from last week presented the=\n letter fairly, and I think it came out rather sympathetic to our position.=\n The Indian papers have been neutral to negative. For example, an editorial=\n (reprinted below) was in Wednesday\'s Financial Express, a business daily i=\nn India (but not as widely circulated or respected as The Economic Times or=\n The Business Standard). Note the editorial below says your letter states "=\nthat any government found to have expropriated the property of US firms aut=\nomatically faces sanctions from that country." Your letter did not state th=\nat, but this is a holdover from the earlier Financial Times interview.\n\nMany people I have met with in the Indian government have made references t=\no the letter, saying they do not think it was appropriate. I respond by say=\ning that given our 9 year history of nothing but frustrations, and the lack=\n of progress over the past 2 months, we do think it is appropriate and it r=\neflects our current views regarding our experience in India. Generally, whe=\nn they mention it time and again, it probably means the letter is having at=\n least some of its intended effect.=20\n\nI\'ll keep you, Stan and Jim updated as we hear more from the Indian governm=\nent.\n\nWade\n\n\n\n\n\n\n\n\nNikita Varma\n09/26/2001 12:03 PM\nTo:=09Nikita Varma/ENRON_DEVELOPMENT@ENRON_DEVELOPMENT\ncc:=09 (bcc: Wade Cline/ENRON_DEVELOPMENT)\n\nSubject:=09From The Enron India Newsdesk - September 26th Newsclips\n---------------------------------------------------------------------------=\n----------------------------------------------------------------------\nTHE FINANCIAL EXPRESS, Wednesday, September 26, 2001\n\n\nLay off, Mr Lay (Editorial)\nEnron tries terror tactics\n\nEnron Corporation\'s CEO Kenneth Lay has reportedly written a letter to Prim=\ne Minister Atal Bihari Vajpayee warning him of adverse consequences to the =\nIndian economy if the Dabhol Power Company imbroglio is not resolved quickl=\ny. He says that if Enron receives anything less than its full investment in=\n DPC, it would amount to an act of expropriation. He further points out tha=\nt any government found to have expropriated the property of US firms automa=\ntically faces sanctions from that country. Reportedly, the letter was writt=\nen three days after the attack on the World Trade Centre. So Mr Lay probabl=\ny ought to be forgiven for reading more than he should into the "dead or al=\nive" rhetoric of his pal, George W Bush, whose election campaign Mr Lay gen=\nerously funded. Saner counsel has since prevailed even at the White House; =\nand far from imposing fresh sanctions, the US government is busy buying sup=\nport even from countries such as Pakistan by lifting sanctions and offering=\n a hefty aid package. Enron has never hesitated to use the considerable eco=\nnomic and political clout of the US government in pushing the Dabhol projec=\nt at various times. Post September 11, the US government - which is in fact=\n \'rewarding\' Pakistan despite its clearly identified role in funding terror=\nist groups - ought not to be terrorising India on Enron. Hence, it is entir=\nely appropriate for the Prime Minister to borrow that little Americanism, r=\necently made popular by Pervez Musharraf, and ask Kenneth Lay to lay off!\n\nInterestingly, Mr Lay\'s letter apparently makes no mention of several impor=\ntant facts that will dictate how much India may have to pay Enron. These in=\nclude the findings of the Madhav Godbole committee report which expose subs=\ntantial overcharging by DPC on several counts and reveals excess capacity c=\nreated for port handling and regassification. Moreover, DPC\'s inability to =\nramp up the power plant to full contracted capacity within the specified ti=\nme period has enormous penal provisions attached to it. This serious techni=\ncal deficiency apart - which alone is grounds enough for repudiating the DP=\nC contract - the government also has a good case to charge the US company w=\nith fraud and misrepresentation. The Maharashtra government \'s judicial inq=\nuiry only makes India\'s case stronger. Let us not allow ourselves to be pus=\nhed around by Enron\'s threats and political connections.\n\n', 'mid': '26112614.1075852812307.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/563.', 'bcc': ['stanley.horton@enron.com', 'a..hughes@enron.com'], 'to': ['kenneth.lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '563.', 'date': '2001-09-26 14:07:52-07:00', 'folder': 'inbox', 'subject': 'Reaction to Ken Lay Letter to Indian Prime Minister'} 
    
    {'_id': ObjectId('52af48b7d55148fa0c19a7f1'), 'sender': 'wms@kainon.com', 'recipients': ['kenneth_lay@enron.com'], 'cc': [], 'text': 'Hello again.  Out of all of the stuff in the media, this is the most\ninformative of all we have seen.\nVery well said.  We wish all the best for those effected and Houston as we\nmove through this.\nWhen the dust clears, Enron will be remembered as a pioneer and great\ncorporate citizen.\n\nBest, Mark\n\nW. Mark Shirley, CPA\n281.374.6700x230\nwww.kainon.com\n\n\nEnron Is History, Says History\nBy HOLMAN W. JENKINS JR.\n\nNovember 28, 2001\nBusiness World\n\nBack in the mid-1980s, a pipeline executive called Ken Lay was fishing\naround for a name for his company, produced by a merger of Houston Natural\nGas and Omaha-based InterNorth. He consulted with consultants, politicked\nwith politicians, and came up with a moniker. The company would be called\n"Enteron."\n\nThree weeks later, fed up with the wisecracks from a press that had looked\nup the dictionary definition of "enteron" (n. the intestine), he changed the\ncompany\'s name again. Henceforth it would be known as Enron.\n\nA columnist less devoted to high standards of decorum might be tempted to\nextend the metaphor of the company\'s misbegotten name. In recent weeks,\nafter all, we\'ve seen Enron\'s stock collapse over indigestible accounting\nand the emergence of dealings between the company and its senior officers\nthat exude an odor of genuine malfeasance. The evidence is far from clear,\nbut for the sake of Mr. Lay\'s reputation one hopes these missteps will prove\none more case of a company fooling itself rather than setting out\ndeliberately to defraud the markets.\n\nEnron grew to be much more than a pipeline hauler of natural gas, becoming\nthe pre-eminent trader and marketer of all kinds of energy contracts and a\nvocal proponent of deregulation. Now, all but overnight, it\'s kaput, just\nwaiting to find out if its fate will be bankruptcy or absorption by an\nerstwhile rival.\n\nWe cannot help be put in mind of another commodity wunderkind in the 1970s,\nPhibro (short for Philipp Brothers). Hard to believe, but Phibro was once a\nname that made grown men quiver on Wall Street. Fattened by trading profits\nfrom the great commodity inflation of the 1970s, which some mistook for a\npermanent new age of scarcity, it scooped up the Street\'s oldest\npartnership, Salomon Brothers, tucking it into its back pocket and renaming\nthe combined firm Phibro-Salomon. Here was a powerhouse of unlimited\npotential, investors told themselves.\n\nFlash ahead to California\'s electricity meltdown earlier this year. Enron\nsaw its revenues quadruple partly as a result of the inflated prices being\nquoted in the California market. Many foresaw a new scarcity megatrend, but\nthere was no true energy shortage. Posted prices on the California power\nexchange may have skyrocketed, but the effective price was zero dollars and\nzero cents, because the utilities had no cash to pay and politicians were\nthumbing their noses at piles of IOUs.\n\nWhen prices are zero, suppliers take a hike -- that\'s what economics\nteaches. But once the state government started pumping its own cash into the\nmarket, the phony posted prices plummeted and supplies became plentiful\nagain. Now California is swimming in power and nobody talks about an "energy\ncrisis" anymore.\n\nYou can date the loss of investor confidence in Enron almost exactly to the\nmoment when the California fiasco began to repair itself. Fortune Magazine\nput the inaugural nail in Enron\'s coffin in March, noting that the company\'s\ngrowing dependence on trading had turned it into an oil-patch version of\nGoldman Sachs. Goldman\'s stock sells at a price-earnings multiple of 17,\nreflecting investors\' well-founded distrust of trading earnings to be\nreproduced reliably year after year. So why, the magazine asked, was Enron\nawarded a multiple of 60-plus? Mmm...\n\nEnron did yeoman service as a champion of deregulation. Boss Ken Lay, a\nbeliever in technology and the power of markets, was a true visionary, to\nthe point of annoying people who didn\'t care for his air of being a man on\nthe right side of history. The moldering pipeline he took over would\ncertainly have been an also-ran if he had not thrown Enron headlong into\ntrading and marketing.\n\nBut deregulation doesn\'t confer permanent advantage on anybody. A\nderegulated environment favors constant innovation and a continual upsetting\nof plans and strategies.\n\nAdd the fact that, despite the California bubble, there is no reason to\nbelieve energy prices won\'t continue their long-term relative decline as\ntechnology advances more quickly than the depletion of conventional\nresources. Add also the likelihood that information technology will continue\nto lower the barriers to entry to Enron\'s trading business, which means more\ncompetition and shrinking margins. Enron begins to look a lot like Phibro.\n\nThe great commodity-trading machine was already running down by 1981, when\nit bought Salomon and Wall Street was swooning. Inflation was being quelled\nby Paul Volcker. The products that Phibro traders bought and sold were\nincreasingly being traded transparently on electronic exchanges. "Four or\nfive years ago, they used to be able to take other companies to the\ncleaners, because they knew where the market was and others didn\'t," a\ntrader explained. "With everyone knowing, within a few cents, where the\nprice of any product was, Phibro\'s ability to make a profit off its superior\nknowledge disappeared."\n\nNot only is this true of Enron, but of its would-be bottom fisher, Dynegy,\nrun by Mr. Lay\'s Houston homeboy, Chuck Watson. Dynegy\'s proposed takeover\nof its former nemesis was hanging by a negotiation yesterday.\n\nWhile Enron in recent years was selling hard assets and concentrating on\nelectronic market-making, Mr. Watson was doing the opposite. His big play in\nthe Enron deal is to get his hands on the original HNG-InterNorth pipeline,\nnow known as Northern Natural Gas. By having both feet planted in the real\nbusiness, he claims his firm will be able to make a profitable sideline out\nof trading despite growing competition and transparency.\n\nWe\'ll see. Dynegy and Enron were born at the same time, and of the same\nmotive. Dynegy was originally created by six pipeline companies, a\nWashington law firm and Morgan Stanley to take advantage of new\nopportunities in deregulated natural gas. But the gnats are already\ncircling.\n\nGas producers who have claimed for years that the duo control too much of\ntheir fate now insist they shouldn\'t be allowed to merge. Don\'t listen to\nthe fussbudgets. If this was a business in need of trustbusting, Enron\nwouldn\'t have been resorting to funny accounting to make its earnings. As\nMerrill Lynch\'s Donato Eassey has pointed out, wholesale margins have been\nsteadily thinning as trading becomes more transparent and competitive.\n\nWishful accounting has time and again proved the last refuge of companies\nwhose dearly held "visions" were not panning out. Enron prided itself on\nbeing realistic and adaptive, but it failed to see that its own beliefs\nabout the world needed overhauling.\n\n----------------------------------------------------------------------------\n----------------------------------------------------------------------------\n--------\n"It ain\'t what you don\'t know that gets you in trouble; it\'s what you know\nfor sure that ain\'t so."       -Mark Twain\n\nK   A   I   N   O   N      G   R   O   U   P\nConsulting  +  Staffing  +  Recruiting', 'mid': '29221017.1075860836207.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/702.', 'bcc': [], 'to': ['kenneth_lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '702.', 'date': '2001-11-28 09:52:46-08:00', 'folder': 'inbox', 'subject': 'Enron Is History, Says History per the WSJ Page A19'} 
    
    {'_id': ObjectId('52af48b7d55148fa0c19a800'), 'sender': 'cannon_craig@yahoo.com', 'recipients': ['kenneth.lay@enron.com'], 'cc': [], 'text': 'Dr. Lay,\nWhat a joke ... Do realize how lives you and your\nboard of directors have ruined >>>> all because of\ngreed and power .... I looked up to for a while\nbuilding a great company nice place to work  but then\ngreed got in your way ... Lets hear again why Skilling\nquit ?? because of family ... BS. Over the past ten\nyears i have worked at\nEnron as a computer contractor in payroll and i saw\nthe outlandish executive bonuses and money to the\nislands.  I hope you get justly fined and sent to\nprison for the fraud you have committed. The few\nshares\nof enron i have left are not worth the paper they are\nprinted on.....i also saw all the stock options you\nand the board have excersied over thats few years 100s\nof million dollars what a shame ...\n  When you opted to replace the oracle Payroll with\nSAP I new you were loosing your mind ....\n\nall the great people that made you now have to find a\njob replace their retirement and hope for the best.\n\nI hope we never meet ...\n\ncraig cannon a stock holder\n\n__________________________________________________\nDo You Yahoo!?\nYahoo! GeoCities - quick and easy web site hosting, just $8.95/month.\nhttp://geocities.yahoo.com/ps/info1', 'mid': '25382603.1075860836635.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/inbox/716.', 'bcc': [], 'to': ['kenneth.lay@enron.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '716.', 'date': '2001-11-29 07:03:29-08:00', 'folder': 'inbox', 'subject': 'GREED'} 
    
    {'_id': ObjectId('52af48b7d55148fa0c19ab07'), 'sender': 'lizard_ar@yahoo.com', 'recipients': ['ealvittor@yahoo.com'], 'cc': [], 'text': "Dear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/", 'mid': '23004808.1075840270949.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/notes_inbox/526.', 'bcc': [], 'to': ['ealvittor@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '526.', 'date': '2000-11-05 23:13:00-08:00', 'folder': 'notes_inbox', 'subject': 'Get out the Vote'} 
    
    {'_id': ObjectId('52af48b7d55148fa0c19abf1'), 'sender': 'peter.blackmore@compaq.com', 'recipients': ['babbio@verizon.com', 'lynnj@iname.com', 'ted.enloe@compaq.com', 'ghh@telcordia.com', 'klay@enron.com', 'kjewett@kpcb.com', 'kenroman@worldnet.att.net', 'lucie@jhmedia.com', 'michael.capellas@compaq.com', 'michael.capellas@compaq.com'], 'cc': ['michael.capellas@compaq.com'], 'text': 'Pleased to send you the November report. Obviously the market is weakening\nin North America which is making the quarter challenging but the underlying\nmomentum of the company continues to improve as the report illustrates.\nLook forward to seeing you at the Board meeting.\n\nRegards,\nPeter\n\n\n\n> [Compaq Confidential - Internal Use Only]\n>\n> To:  Global Sales & Services Team\n>\n> Before I report on the great wins and other news this month, I want to\n> express a personal note about the organizational announcement earlier this\n> month.  I\'m excited about the changes for all the reasons already\n> communicated - in particular strengthening the integration of our upstream\n> and downstream operations.  I\'m also excited about Bo McBee and his\n> worldwide team in Corporate Quality and Customer Satisfaction officially\n> joining our organization.  He and his team are doing a great job, and\n> together we will further our efforts to become the leader throughout the\n> world in satisfying our customers.\n>\n> Most of all, I am extremely pleased and encouraged because I believe these\n> changes confirm the great work you have accomplished this year.  We\'ve\n> already reported a number of major wins as a result of the joint efforts\n> by our Sales and Services teams.  There is an air of excitement and\n> anticipation about Compaq\'s momentum - I see it in the emails from many of\n> you and as I meet with our teams and customers around the world.  You\'re a\n> remarkable team and, as Michael puts it, let\'s keep the pedal to the metal\n> and keep the momentum strong as we work to successfully close 2000!\n>\n> Speaking of my travels...\n> This month I visited Johannesburg, South Africa, Dubai within the United\n> Arab Emirates, and Saudi Arabia.  All of these countries are part of\n> EMEA\'s Business Development Group (BDG), which is responsible for\n> developing Compaq business in 98 countries. The group is focused on both\n> developed and emerging markets in Eastern Europe, the Middle East and\n> Africa. Over the past six years, BDG has grown its revenue more than\n> 10-fold.\n>\n> In South Africa I visited Vodacom, which with 4 million subscribers, is\n> Africa\'s largest mobile phone network operator.  The company has just\n> upgraded its billing systems to handle further expansion, and to date is\n> one of the world\'s largest Wildfire installations with some 21 AlphaServer\n> GS systems.  I also spent time with the management of Mobile Telephone\n> Networks (MTN), South Africa\'s #2 cellphone operator and another big\n> Wildfire customer.  In fact, we just got word that they\'ve placed a $10M\n> order for four GS320 AlphaServer systems and storage.\n>\n> One of my more interesting activities while there was learning more about\n> Ikageng, a Compaq-led initiative to bring the benefits of the information\n> age to the rural communities of Africa.  Ikageng brings together the\n> provision of safe drinking water, affordable healthcare, distance\n> learning, improved subsistence farming techniques and Internet access.\n> All of this is co-funded by a community bank, together with Compaq,\n> Johnnic, a South African media and information group, and the active\n> participation of the World Bank.  A real example of Inspiration Technology\n> at work!\n>\n> My visit to the United Arab Emirates included a dinner with our top 30\n> customers from across the region, a VIP lunch with our top partners, as\n> well as meetings with employees in the region.  I also attended Gitex, the\n> region\'s largest IT exhibition, and met with press at that event to convey\n> Compaq\'s commitment to the UAE.  I was also privileged to have a personal\n> meeting with His Highness Sheik Mohamad bin Rashid al Maktoum, Crown\n> Prince of Dubai and the Minister of Defense.  These meetings were around\n> the official opening of Dubai Internet City, an area of Dubai dedicated to\n> making the city the "Silicon Valley"  of the Middle East.\n>\n> I spent a very interesting day at Aramco in Saudi Arabia, our largest\n> account in the UAE. We are the ProLiant standard in this very large energy\n> company and we have a great opportnuity to build a strong partnership\n> across many additional solutions including high performance technical\n> computing, ZLE applications and enterprise storage, in addition to\n> recapturing client business from the competition\n>\n> Some of our largest wins this month\n> * Tokyo Stock Exchange - We are replacing Hitachi at the world\'s third\n> largest stock exchange, with a $60-80M order for Himalaya systems. This\n> contract should bring in an additional $20-30M in Professional Services.\n> *      Eli Lilly - Signed the first leg of a three-year global agreement\n> valued at $100M, securing Compaq as the sole supplier for Intel-based\n> products, forcing Dell off the customer\'s standards list and opening the\n> door for StorageWorks products, Global Services and high-performance\n> servers.\n> *      Winstar - Four-year, $100M contract as the exclusive provider of\n> Windows NT and storage products, including $10M in AlphaServer systems\n> running Tru64 UNIX.\n> *      Mead Corp. - Beat IBM, HP and Dell for a five-year, $50M contract\n> for ProLiant servers, storage, desktops, portables and services.\n> * France Telecom - $30M contract for a global agreement (includes all\n> subsidiaries) for a complete line of AlphaServer systems, including DS, ES\n> and GS series as well as ProLiant servers.\n> * General Motors - Selected as the global Intel-based server standard\n> for new application deployment at GM manufacturing facilities. The\n> anticipated global revenue is $30M over three years.\n> * Electronic Classroom of Tomorrow - $25M for ProLiant 8500 servers,\n> StorageWorks products and legacy-free iPAQ desktops.\n> * FleetBoston Financial - Beat IBM, Dell and HP for a $40M desktops\n> contract\n> * Airgroup (Switzerland) - Beat IBM and NetVista for a  $21M contract\n> for 20,000 iPAQ desktops.\n> * DLI (Korea) - $22M for Professional Services.\n> * AltaVista - Shut out IBM and HP by putting into place a $25M fair\n> market value lease for ProLiant- and Alpha-based servers, increasing the\n> AltaVista lease line to $75M.\n> * ASP Host Centric - One of the eight North America-certified Oracle\n> Authorized Application Providers (OAAP), the firm will standardize its\n> UNIX environment on AlphaServers, replacing Sun systems. This project\n> could generate more than $20M for us over the next 36 months.\n> * Interfusion - Three-year, $20M contract for a Tru64 UNIX-based\n> solution.\n> * Westcoast Energy- Topped Dell for a desktop and portables contract\n> valued between $15-20M.\n> * General Electric - Five-year, $15.4M contract for worldwide Lotus\n> Domino rollout and expansion of Exchange rollout, including NT Server\n> management outsourcing.\n> http://newscpq1.inline.cpqcorp.net/article.cfm?storyid=1146\n> * Moebel Pfister - $15.7M outsourcing contract.\n> * TriRiga - Beat Dell, EMC and Sun for a two-year, $15M contract for\n> storage, Professional Workstations, desktops, portables and services.\n>\n> EMEA to open Wireless Competence Centre in Stockholm\n> Press, customers and partners have been invited to help officially open\n> the Compaq Wireless Competence Centre in Stockholm, Sweden, on November\n> 27.  The centre is the company\'s first facility to fully display our\n> unique end-to-end capabilities of  solutions, services and products in the\n> mobile Internet and wireless space.  The hands-on centre showcases today\'s\n> wireless solutions within four environments - car, home, office and public\n> access areas.  Technologies featured include GSM, GPRS, future 3G\n> standards, WLAN and Bluetooth.  Compaq\'s mobile partners such as Nokia,\n> Oracle, Cisco, Microsoft, Siebel and Ericsson also plan to participate in\n> the opening.  The centre is already hosting customer visits and will\n> engage with thousands of customer and partners over the coming year\n> through a mix of seminars, tours and customized workshops.  For more info,\n> see  http://inline-se.soo.cpqcorp.net/wireless/\n>\n> Planning for Innovate Forum 2001 under way\n> Compaq\'s premier event for its global and large account customers -\n> Innovate Forum 2001 - is set for May 23-24 at the George R. Brown\n> Convention Center in Houston.  The hand-picked guest list will include\n> some 4,000-5,000 senior-level technical and business executives, including\n> our key channel partners, press, industry and financial analysts, and\n> Compaq\'s key alliance partners.  The program will feature keynote\n> speeches, plenary sessions, special interest seminars, a solutions\n> pavilion, and social events.  For more information, see the Innovate site\n> on Inline:  http://inline.compaq.com/na/innovate/\n>\n> Cross Border Office files first lawsuit\n> The Cross Border Office has been created to prevent unauthorized movement\n> of Compaq products by dealers and gray market brokers in order to protect\n> profit margins and ultimately, customer satisfaction.  The Cross Border\n> team provides gray market awareness training to all sales personnel, mail\n> and phone hotline access to report gray market activity, works jointly\n> with regional sales, services, business unit and channel teams to create\n> policy and procedures to reduce gray market activity and, working with the\n> Law department, to bring legal action against gray market brokers if\n> warranted.\n>\n> As a result of these efforts, Compaq has filed its first lawsuit against\n> two Canadian technology consulting firms for breach of contract and fraud.\n> The suit, which seeks compensatory damages of more than $17 million,\n> claims the consulting firms fraudulently represented to Compaq that they\n> had a contract with the U.S. Department of Transportation\'s Federal\n> Aviation Administration to supply a large number of computers and related\n> equipment to U.S. airports. This lawsuit hit many national publications\n> and sends a message to the worldwide gray market community that Compaq\n> will take actions to protect its authorized resellers, product quality and\n> our customers.\n>\n> For further information on the Cross Border Office, gray market red flags\n> and to view the web-based training video, see\n> http://inline.compaq.com/wwsm/crossborder/index.asp\n>\n> Key Channel Partner programs rolling out\n> Early this year the Tigerbite project was established to redefine and\n> simplify Compaq\'s model with our channel partners.  A key element of the\n> model is worldwide programs that provide profitable growth opportunities\n> for Compaq and its partners.  Two such programs - Internet List Pricing\n> (ILP) and the Compaq Agent Program - are currently being implemented by\n> the regions.\n>\n> Worldwide implementation of ILP is a top priority for the company.\n> Creating and publishing (where needed) competitive List Prices is\n> absolutely essential to establishing a more consistent, worldwide pricing\n> model for both our customers and partners. By the end of this month ILP\n> will have been implemented in North America, Latin America, Japan and\n> Greater China, with pilot programs in Singapore and Malaysia.  EMEA and\n> the remaining Asia Pacific countries are expected to complete the rollout\n> by January 1, 2001.\n>\n> The Compaq Agent Program, which allows partners to earn commissions when\n> they refer customers to purchase products/services directly from us,\n> currently has been implemented in the U.S., Latin America (14 countries)\n> and CKK.  This month, APD is implementing pilot programs in Singapore and\n> Malaysia, and plans to roll out the program in seven additional countries\n> in the first quarter.  EMEA held an Agent Program Summit this month with\n> 10 countries to assess and develop their 2001 rollout plans which include\n> adding Enterprise-class products to their program next year.\n>\n> News from the Compaq Alliances team\n> *      Compaq regained the #1 platform partner position with SAP with 33%\n> market share over all platforms (NT, UNIX with R/3, and mySAP.com). IBM is\n> 2nd in line with 23% share. In North America alone, our overall SAP share\n> increased from 25% to 32% in the third quarter.  As an aside, SAP\'s entire\n> executive board and senior executive staff use our iPAQ Pocket PCs.\n> Rollout of the product to SAP Sales and Marketing is also in progress -- a\n> very visible endorsement of Compaq\'s leadership in Internet access as it\n> applies to enterprise applications.\n> * Cable & Wireless CEO and executive visit to Marlboro in October\n> included CEO Graham Wallace and 56 top C&W executives. C&W new ASP\n> \'a-Services\' UK launch on October 31 followed the successful U.S. launch\n> in late September.\n> * Compaq secured the notebook business with CGE&Y UK for their\n> internal use.  Toshiba had been the incumbent for 5 years.  CGE&Y is\n> upgrading to Oracle 11i on Alpha Tru64 UNIX.  As one of the first\n> customers globally to upgrade to 11i on Alpha, they have agreed to be a\n> reference site.\n> * Our successful Platinum Sponsorship of Commerce One\'s Global Trading\n> Web Technical Forum included a Compaq keynote and non-disclosure breakout\n> session on new ProLiant 8-ways.\n> * A  9-city roadshow in EMEA was kicked-off with Intel, starting in\n> Munich.  This is an extension of the successful 11 city roadshow in the\n> U.S. that drove traffic to the speedStart website and should do the same\n> for EMEA..\n> * Strong Compaq presence with Premier sponsorship at Oracle Open World\n> in October included Michael Capellas luncheon speech to 200+ C-level\n> customers, on-stage server presence at Larry Ellison keynote, and\n> excellent Compaq coverage in Oracle publications.\n> * Announced major Mid-Market Initiative Contract with Siebel.  We had\n> very high visibility at Siebel User Week, and also won Siebel\'s Platform\n> Partner of the Year awards for Excellence in EMEA and NA.  We recently\n> announced a Benchmark Figure of 10,200 Siebel users running Microsoft NT\n> and SQL 7 on ProLiant systems.\n> * Compaq had a strong presence at COMDEX with strategic partner,\n> Microsoft.  In addition to  supporting Bill Gates\' keynote address, the\n> Microsoft booth featured iPAQ Pocket PCs demonstrating the award-winning\n> OmniSky wireless Internet and e-mail service running on Metricom\'s\n> Ricochet network - the world\'s fastest mobile broadband network.\n> Microsoft also announced the immediate availability of its Windows Media\n> Player Technology Preview Edition on Compaq Pocket PCX devices, which for\n> the first time delivers streamed wireless Windows Media-formatted audio\n> and video to a portable device.\n>\n> Global Accounts news\n> * Do you know about the Discovery, Design and Implementation (DDI)\n> application? Global Accounts has moved the DDI application into\n> production, resulting in a Web-enabled tool that streamlines and automates\n> the DDI phases for signing up new customers.\n> http://vinproapp03.cce.cpqcorp.net/ddi/\n> * More than 130 people from Compaq EMEA Global Accounts attended a\n> conference center at EuroDisney, Paris, for a training program that\n> included a focus on personal development skills and a broader look at how\n> Global Accounts can build sales.\n\n> * A CD and brochure designed to give Global Accounts salespeople and\n> customers a greater insight into the business can be ordered online\n> through the GA catalog.\n> http://inline.compaq.com/corpmktg/globalaccounts/know/resourcekit.asp\n> * For the first time, Compaq has a single, documented global special\n> pricing process, enabling us to be smarter than the competition on global\n> bids.  Implementation of this process is expected to begin January 1. For\n> more information, see\n> http://inline.compaq.com/corpmktg/globalaccounts/div/stratplan/index.asp\n> or e-mail Philip Kyle.\n> * Global Account managers and others whose customers and prospects\n> require multi-platform hardware, operating systems and applications will\n> want to know about the IQ Center. With more than 150 systems engineering\n> personnel, 30,000 square-feet of lab space, 500 CPUs and 100 TB of\n> storage, the Center is a well-equipped, one-stop shop for designing and\n> testing complex solutions.\n> http://inline.compaq.com/corpmktg/globalaccounts/div/gamclose.asp\n>\n> CPCG headlines\n> * Compaq regained total PC and PC server market share leadership in\n> the UK during 3Q.\n> * Among our many announcements at Comdex, we introduced the\n> three-pound, MP2800 - the world\'s smallest projector -- as well as\n> iPAQnet, a collection of products and solutions designed to redefine the\n> Internet experience for customers demanding wireless access to e-mail and\n> other corporate information. Last, Compaq and Oracle announced an all-new\n> Internet appliance based on ProLiant servers and the latest Oracle\n> software to deliver the fastest cache on the Internet. Oracle is backing\n> up the performance pledge with a $1 million guarantee.\n>\n> Ratings and reviews\n> * Computer Shopper named the iPAQ Pocket PC one of the "Top 100\n> Products of 2000"\n> * "Looking for the perfect present for the technophile who has\n> everything? Then check out the Compaq iPAQ Pocket PC ... the iPAQ is a lot\n> slimmer than most of the competition ... Plus, its brilliant 12-bit,\n> 4,096-color reflective display will be sure to make the holiday season\n> especially bright." - ZDNet\n> * Popular Science recognized the iPAQ Pocket PC at an awards ceremony\n> for being one of the year\'s 100 "hottest products and eye-opening\n> discoveries." The iPAQ Pocket PC is pictured on the cover of the\n> magazine\'s December edition, now on newsstands.\n> * "Sure, the Compaq iPAQ Pocket PC PDA has everything a desktop PC has\n> - word processor, Internet browser, e-mail engine, etc., etc. But that\'s\n> not even half the story: It can crank out color video and blast MP3 music\n> through a stereo headphone jack..." - Stuff Magazine\n>\n> Portables garner praise\n> * The Armada E500S received the "Four-Star Award" from Computer\n> Shopper. "Overall, the Armada E500S is a compelling, well-designed package\n> for small businesses ... you get a solid mix of components for the money."\n> - Computer Shopper\n> * The Notebook 100 was named one of the Top 100 Products of the Year\n> by Computer Shopper. "We were duly impressed with Compaq\'s price-defying\n> Notebook 100."\n>\n>\n> Consumer Group highlights\n> * Last month, we shipped our 500,000th Configure-to-Order unit. U.S.\n> CTO sales grew 256% in the third quarter.\n> * Worldwide beyond-the-box revenue in Q3 increased 90% year-over-year.\n> * Of the top 25 countries with the highest Consumer sales worldwide,\n> six are in the Latin America region: Mexico (2), Brazil (4), Argentina\n> (8), Chile (16), Peru/Bolivia (21) and Colombia (22).\n> * Consumer\'s EMEA region hit the $1 billion sales mark in mid-October,\n> two months earlier than in 1999.\n> * More than 50,000 DSL-ready Presario computers have been sold through\n> our deal with Southwestern Bell.\n> http://newscpq1.inline.cpqcorp.net/article.cfm?storyid=1034\n> * Popular Science magazine included the iPAQ Home Internet Appliance\n> in its "Best of What\'s New" in the computer and software category.\n>\n> Storage Product Group news\n> *      Compaq Belgium and Luxembourg have won four DATANEWS Awards for\n> Excellence, one of which was in the category of Enterprise Storage: Compaq\n> StorageWorks systems. Compaq also received Awards of Excellence for\n> Enterprise Server (ProLiant); High-End Workstations (Compaq Professional\n> Workstation), and Services. The Compaq Aero Professional Digital Assistant\n> (PDA) received a Quality Award. For more info, visit:\n> http://datanews.vnunet.be/dnafe0.asp\n> *      An elite group of storage networking companies has joined our\n> commitment to support VersaStor Technology - the industry\'s premier\n> implementation of networked storage pooling. These endorsements represent\n> an important milestone in enabling SAN customers to leverage business\n> information as a virtual resource.\n> http://www.compaq.com/newsroom/pr/2000/pr2000103002.html\n> * Construction has begun on the Storage Networking Industry\n> Association Technology Center (SNIA Technology Center) in Colorado\n> Springs, Colo. Upon completion, the 14,000-square-foot center will be the\n> largest independent storage networking lab in the world.\n> http://storage.inet.cpqcorp.net/download/doc/SNIA_Release_final.doc\n> * At last month\'s Storage Networking World conference, Compaq and IBM\n> demonstrated for the first time true multi-vendor online storage\n> interoperability for the Open SAN Earlier this month we announced three\n> new storage service offerings that accelerate SAN implementation, improve\n> enterprise backup performance and increase availability and reliability of\n> remote storage management.\n> http://www.compaq.com/newsroom/pr/2000/pr2000103001.html\n>\n> Business Critical Server Group highlights\n> * Our Tru64 UNIX business is gaining momentum - growing twice as fast\n> as the market in Q2 and Q3 of this year, according to International Data\n> Corp. IDC reports that Compaq was the fastest growing UNIX vendor in Q2,\n> with 25% growth versus overall UNIX market growth of 13%.\n> * On Oct. 31, we announced new Tru64 UNIX, TruCluster and AlphaServer\n> products and services enhancements to improve scalability and ease of\n> deployment for e-business solutions.\n> http://alphaserver.inet.cpqcorp.net/announcements/30oct00/index.html\n> * The International Tandem Users\' Group (ITUG) Summit 2000, held Oct.\n> 15-19 in San Jose, Calif., was the largest ever, drawing 2,900 customers,\n> partners, internal developers and executives. A highlight of the general\n> session was a live demonstration of the Zero Latency Enterprise\n> architecture for customer relationship management, which brings together\n> Himalaya, AlphaServer and ProLiant platforms.\n>\n> North America eBusiness Solutions successes\n> *      Service Provider Winstar has signed Compaq as its exclusive\n> provider of NT and storage products and committed to purchase a minimum of\n> $100M of Compaq products over the next four years, $10M of which will be\n> for Alpha UNIX for their rapidly growing complex hosting business.  We\'re\n> also providing $50M in financing directly to Winstar and $50M in financing\n> to approved Winstar customers.  Compaq Services has been designated as a\n> Winstar Services Partner.\n> *      Exodus placed an initial order of more than 500 ProLiant servers\n> for their Intel-managed hosting platform.\n> * Compaq also inked a deal with Siebel Systems to create a dedicated\n> partner sales channel and a $30M joint marketing initiative for an\n> integrated hardware/software offering to small and medium enterprises.\n> Over 80 sales agents are being authorized to sell the packages, which are\n> delivered fully integrated by Compaq Direct.\n>\n> Compaq Financial Services making a difference\n> *      Compaq Financial Services was instrumental in helping to shut out\n> IBM and HP from long-time Compaq customer AltaVista by putting into place\n> a $25M fair market value lease for NT and AlphaServers.  Through the deal,\n> CFS increased Alta Vista\'s lease line to $75M.\n> * CFS scored its first local currency financing in Brazil with a $3M\n> deal for servers and services.  In awarding the contract over competitors\n> HP and IBM and their respective financing groups, Ericsson cited\n> differentiating factors including Compaq\'s technology and our ability to\n> provide a competitive price in local currency.  CFS invoicing\n> capabilities, including information for each separate Ericsson cost center\n> in Brazil, was also a deciding factor.\n> * CFS helped facilitate the largest delivery of Intel servers\n> (ProLiant ML 370) to the Czech Republic through a $2.8M, 3-year operating\n> lease transaction with Czech Savings Bank.  CFS was the only leasing\n> company to offer a sub-lease structure, a differentiating factor that won\n> the business over Dell and IBM.\n>\n> CEI changes name to Compaq Direct\n> Custom Edge Inc., a wholly owned Compaq subsidiary formed, is now called\n> Compaq Direct. In other "direct" news, did you know that we have more than\n> 230 major accounts now buying from us directly and more in the pipeline?\n> Combined revenue in Q3 from PartnerDirect, DirectPlus, Major Account\n> Direct and GEM Direct totaled nearly 40 percent of CPCG\'s total revenue in\n> North America. What\'s more, ISSG revenue was more than 27 percent direct\n> in Q3.\n>\n> Siebel\'s Platform Partner of the Year\n> I\'m pleased to report that Siebel has named Compaq its Platform Partner of\n> the Year for excellence in both EMEA and North America. We recently\n> received high visibility at the Siebel User Week event while also\n> announcing a record benchmark of 10,200 Siebel users running Microsoft NT\n> and SQL 7 on ProLiant servers.\n>\n> Get Informed\n> Inform, Compaq\'s customer magazine, is now available in printed and\n> electronic versions. It\'s free and available for you to read. Sign your\n> customers up by visiting the U.S. (www.compaq.com/inform/issues/sb.html),\n> Asia Pacific (www.compaq.com.tw/) or EMEA (www.compaq.com/emea/inform)\n> sites.\n>\n> North America eCommerce and CRM marketing activities\n> * North America recently released IMPAQ express, a Web-based tool for\n> Customer Relationship Management (CRM) campaign planning and audience\n> sizing, to its marketing and sales force. For the first time, campaign\n> planning can start with a quick and easy look at the size and scope of a\n> potential installed-based audience.\n> * Compaq recently co-sponsored eLink, a B2B e-commerce event targeted\n> at procurement, IT, marketing and financial executives hosted by Commerce\n> One in Las Vegas. Attendees witnessed the on-stage construction of a live\n> e-marketplace powered by Commerce One and Compaq servers. In addition, we\n> demonstrated our Roundtrip configuration and Auction capabilities.\n>\n> Wins Around the World\n> As always, thanks to everyone for your tremendous efforts this month.\n> Please take a few minutes to look over the complete list of recent wins\n> around the world and continue to write me with your news and success\n> stories. http://inline.compaq.com/wwss/wins/worldwins.asp\n>\n> Let\'s finish the quarter strongly!!\n>\n> Regards,\n> Peter\n>\n> ', 'mid': '12685440.1075840277008.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/notes_inbox/739.', 'bcc': ['michael.capellas@compaq.com'], 'to': ['babbio@verizon.com', 'lynnj@iname.com', 'ted.enloe@compaq.com', 'ghh@telcordia.com', 'klay@enron.com', 'kjewett@kpcb.com', 'kenroman@worldnet.att.net', 'lucie@jhmedia.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '739.', 'date': '2000-12-05 02:05:00-08:00', 'folder': 'notes_inbox', 'subject': 'November Blackmore Report'} 
    
    {'_id': ObjectId('52af48b7d55148fa0c19ac21'), 'sender': 'djtheroux@independent.org', 'recipients': [], 'cc': [], 'text': 'Tue, 12 Dec 2000 18:49:21 -0600\nDate: Tue, 12 Dec 2000 18:49:21 -0600\nMessage-Id: <200012130049.SAA07799@server1.pjdoland.com>\nTo: klay@enron.com\nFrom: David Theroux <DJTheroux@independent.org>\nReply-to: DJTheroux@independent.org\nX-Mailer: Perl Powered Socket Mailer\nSubject: THE LIGHTHOUSE: December 12, 2000\n\nTHE LIGHTHOUSE\n"Enlightening Ideas for Public Policy..."\nVOL. 2, ISSUE 48\nDecember 12, 2000\n\nWelcome to The Lighthouse, the e-mail newsletter of The Independent \nInstitute, the non-partisan, public policy research organization \n<http://www.independent.org>. We provide you with updates of the Institute\'s \ncurrent research publications, events and media programs.\n\n-------------------------------------------------------------\n\nIN THIS WEEK\'S ISSUE:\n1. Pentagon "Shocked" to Find Rivers Dammed with Pork\n2. The Environmental Propaganda Agency\n3. William Lloyd Garrison, Antislavery Crusader\n\n-------------------------------------------------------------\n\nPENTAGON "SHOCKED" TO FIND RIVERS DAMMED WITH PORK\n\nCaptain Louis Renault -- Claude Raines\'s cheerfully duplicitous character in \nthe 1942 film classic "Casablanca" -- asserted glibly that he was "shocked, \nshocked" to learn that gambling was taking place at Rick\'s Cafe. Moments \nlater he was only too happy to collect his gambling earnings for the night.\n\nAll this is by way of preamble to a new Pentagon investigation of fraud in \nmilitary construction. The investigation concluded that three senior Army \nCorps of Engineers officials had, just as one whistle-blowing Corps economist \nhad claimed, engaged in a deceitful campaign to justify what the Washington \nPost called "a billion-dollar construction binge on the Mississippi and \nIllinois rivers."\n\n"The [Pentagon] investigators concluded that the agency\'s aggressive efforts \nto expand its budget and missions, as well as its eagerness to please its \ncorporate customers and congressional patrons, have helped \'create an \natmosphere where objectivity in its analyses was placed in jeopardy,\'" the \nPost reports.\n\n"Even the agency\'s retired chief economist told them that Corps studies were \noften \'corrupt,\' and that several Corps employees cited \'immense pressure\' to \ngreen-light questionable projects."\n\nBureaucratic boondoggles of such magnitude are certainly newsworthy. But they \nare hardly news. Just as the Soviets derided the failures of previous Five \nYear Plans (only to implement new, equally flawed versions), so it seems that \nevery few years the Pentagon uncovers massive corruption and waste in its own \ncentrally planned fiefdom -- only to present a new Plan that operates under \nthe same bad incentives that encouraged prior malfeasance.\n\nWith corruption and waste seemingly "taken care of," the worst pork-barrel \nspenders in Congress and the military are then let off the hook, only to \nenjoy -- like Casablanca\'s Renault and Rick -- an amicable toast to the \nbeginnings of a beautiful new friendship.\n\nFor the Washington Post series on the Army Corp of Engineers boondoggle, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-1.html.\n\nFor a summary of the Independent Institute book, ARMS, POLITICS AND THE \nECONOMY: Historical and Contemporary Perspectives, edited by Robert Higgs, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-2.html.\n\n-------------------------------------------------------------\n\nTHE ENVIRONMENTAL PROPAGANDA AGENCY\n\nWill the neck-to-neck presidential race help reduce -- or intensify -- \npressure for the next president of the United States to score points with \nstatist environmental activists?\n\nExcept on a few controversial issues, a strong case can be made that the \nforty-third President of the United States will wish to portray himself as a \nclose friend of "the environment." President George W. Bush, for example, \nwould face strong pressure to show that he is "bipartisan" in his approach to \nenvironmental protection; whereas President Al Gore would likely attempt to \nwin back those who supported Nader and the Greens.\n\nAll the more reason, then, to call attention to the failures of the current \napproach to environmental protection -- especially those emanating from the \nU.S. Environmental Protection Agency, or, as economist Craig Marxsen terms \nit, the Environmental Propaganda Agency.\n\nThe EPA sometimes employs the language of cost-benefit analysis to illustrate \nits seemingly tremendous success, but it is known to employ it in a highly \nmisleading manner. The EPA claimed, for example, that its Clean Air Act \nprograms produced, from 1970 to 1990, $22.2 trillion dollars in health \nbenefits at a cost of only $523 billion. But, reports Marxsen in THE \nINDEPENDENT REVIEW, "[The EPA\'s] study actually represents a milestone in \nbureaucratic propaganda. Like junk science in the courtroom, the study \nseemingly attempts to obtain the largest possible benefit figure rather than \nto come as close as possible to the truth."\n\nIn conclusion, writes Marxsen, "Without the illusory benefit of all the lives \nsaved, the actual benefits of the Clean Air Act were very modest and probably \ncould have been achieved nearly as well with far less sacrifice. The Clean \nAir Act and its amendments force the EPA to mandate reduction of air \npollution to levels that would have no adverse health effects on even the \nmost sensitive person in the population. The EPA relentlessly presses forward \nin its absurd quest, like a madman setting fire to his house in an insane \ndetermination to eliminate the last of the insects infesting it."\n\nFor more information, see "The Environmental Propaganda Agency," by Craig S. \nMarxsen (THE INDEPENDENT REVIEW, Summer 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-3.html.\n\nFor analysis of other EPA programs, see the Independent Institute book, \nCUTTING GREEN TAPE: Toxic Pollutants, Environmental Regulation and the Law, \nedited by Richard Stroup and Roger Meiners, at \nhttp://www.independent.org/tii/lighthouse/LHLink2-48-4.html.\n\nFor Robert Formaini\'s insightful review of Kip Viscusi\'s important book, \nRATIONAL RISK POLICY (THE INDEPENDENT REVIEW, Winter 1999), see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-5.html.\n\n-------------------------------------------------------------\n\nWILLIAM LLOYD GARRISON, Antislavery Crusader\n\n"I will be as harsh as truth, and as uncompromising as justice. On this \nsubject, I do not wish to think, or speak, or write with moderation.... I \nwill not equivocate -- I will not excuse -- I will not retreat a single inch \n-- and I will be heard."\n     -- William Lloyd Garrison, THE LIBERATOR, January 1, 1831\n\nDecember 12 marks the 195th anniversary of the birth of William Lloyd \nGarrison, a leading figure in the American abolitionist movement. As the late \nhistorian Henry Mayer explained in his National Book Award-Finalist \nbiography, ALL ON FIRE: William Lloyd Garrison and the Abolition of Slavery:\n\n"William Lloyd Garrison (1805-1879) is an authentic American hero who, with a \nBiblical prophet\'s power and a propagandist\'s skill, forced the nation to \nconfront the most crucial moral issue in its history. For thirty-five years \nhe edited and published a weekly newspaper in Boston, THE LIBERATOR, which \nremains today a sterling and unrivaled example of personal journalism in the \nservice of civic idealism.\n\n"Although Garrison -- a self-made man with a scanty formal education -- \nconsidered himself \'a New England mechanic\' and lived outside the precincts \nof the American intelligentsia, he nonetheless did the hard intellectual work \nof challenging orthodoxy, questioning public policy, and offering a luminous \nvision of a society transformed. He inspired two generations of activists -- \nfemale and male, black and white -- and together they built a social movement \nwhich, like the civil rights movement of our own day, was a collaboration of \nordinary people, stirred by injustice and committed to each other, who \nachieved a social change that conventional wisdom first condemned as wrong \nand then ridiculed as impossible."\n\nIndeed, without Garrison\'s inflammatory but compelling writing, speaking and \norganizing, there might have been no effective American anti-slavery movement \nat all.\n\nFor more on William Lloyd Garrison, read historian Henry Mayer\'s talk from \nthe Independent Policy Forum, "The Civil War: Liberty and American Leviathan" \n(with Jeffrey Rogers Hummel), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-6.html, or hear it in \nRealAudio at http://www.independent.org/tii/lighthouse/LHLink2-48-7.html.\n\nAlso see Jeffrey Rogers Hummel\'s review of Henry Mayer\'s brilliant biography, \nALL ON FIRE: William Lloyd Garrison and the Abolition of Slavery (THE \nINDEPENDENT REVIEW, Fall 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-8.html.\n\n-------------------------------------------------------------\n\nIf you enjoy receiving THE LIGHTHOUSE ... please help us support it.\n\nYour supporting Independent Associate Membership enables us to reach \nthousands of other people. So, please make a contribution to The Independent \nInstitute. See http://www.independent.org/tii/lighthouse/LHLink2-48-9.html. \nto donate, or contact Ms. Priscilla Busch by phone at 510-632-1366 x105, fax \nto 510-568-6040, email to <PBusch@independent.org>, or snail mail to The \nIndependent Institute, 100 Swan Way, Oakland, CA 94621-1428.\nAll contributions are tax-deductible.  Thank you!\n\n-------------------------------------------------------------\n\nFor previous issues of THE LIGHTHOUSE, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-10.html.\n\n-------------------------------------------------------------\n\nFor information on books and other publications from The Independent \nInstitute, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-11.html.\n\n-------------------------------------------------------------\n\nFor information on The Independent Institute\'s Independent Policy Forums, see\nhttp://www.independent.org/tii/lighthouse/LHLink2-48-12.html.\n\n-------------------------------------------------------------\n\nTo subscribe (or unsubscribe) to The Lighthouse, please go to \nhttp://www.independent.org/subscribe.html, choose "subscribe" (or \n"unsubscribe"), enter your e-mail address and select "Go."\n\nCopyright , 2000 The Independent Institute\n100 Swan Way\nOakland, CA 94621-1428\n(510) 632-1366 phone\n(510) 568-6040 fax\ninfo@independent.org\nhttp://www.independent.org\n', 'mid': '256906.1075840278132.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/notes_inbox/782.', 'bcc': [], 'to': [], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '782.', 'date': '2000-12-12 10:37:00-08:00', 'folder': 'notes_inbox', 'subject': ''} 
    
    {'_id': ObjectId('52af48b7d55148fa0c19acd0'), 'sender': 'rosalee.fleming@enron.com', 'recipients': ['lizard_ar@yahoo.com'], 'cc': [], 'text': "Good morning, Liz -\n\nI left a message at your home this morning that your Dad would like to speak \nwith you when you have a chance to call.  \n\nRosie\n\np.s. - P. L. and I did early voting the first Saturday available!!  It was \nsuch a good feeling as Tuesdays are tough with trying to get to the office \nand leave in time to vote!!\n\n\n\n\n\nElizabeth Lay <lizard_ar@yahoo.com> on 11/06/2000 09:13:26 AM\nTo: ealvittor@yahoo.com\ncc:  \nSubject: Get out the Vote\n\n\nDear Friends and Family,\nWe are down to the wire and the race couldn't be\ncloser. Every vote counts, even those of you in Texas.\nPlease, remember to vote and go early, polls open at\n7am across the country and close at 7pm but don't put\nit off until 7pm as there could be lines and the\nsupervisors are not required to keep the polls open\nafter 7pm for those in line.\nRemind your friends and family to vote and if someone\nneeds transportation to the polls, give them a ride or\ncall your local Victory 2000 office (Republicans) or\nyour local Democratic campaign office, they will have\npeople available to transport people to the polls.\nKeep an eye out while you are at the polls for\nelectoral fraud and report any suspicious activity\nincluding inappropriate campaigning to the poll\nwatchers at the polls. The Democrats and the\nRepublicans will have representatives at most of the\npolls, let them know if there is suspicious activity.\nFinally, if you have time, call your local offices and\noffer your time to make phone calls to encourage\npeople to get out and vote, pass out leaflets, or to\nbe available to help prevent of voter fraud.\n\nFinally, enjoy the evening and watch the results come\nin. There are election watch parties everywhere!!!\n\nJust one more day (and no more mass political e-mail's\nfrom me and everyone else)!\nTake care and VOTE!\nLiz\n\n__________________________________________________\nDo You Yahoo!?\nThousands of Stores.  Millions of Products.  All in one Place.\nhttp://shopping.yahoo.com/\n\n", 'mid': '21859329.1075840279339.JavaMail.evans@thyme', 'fpath': 'enron_mail_20110402/maildir/lay-k/sent/21.', 'bcc': [], 'to': ['lizard_ar@yahoo.com'], 'replyto': None, 'ctype': 'text/plain; charset=us-ascii', 'fname': '21.', 'date': '2000-11-06 01:55:00-08:00', 'folder': 'sent', 'subject': 'Re: Get out the Vote'} 
    
    Total:  23
    
