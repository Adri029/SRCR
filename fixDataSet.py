import pandas as pd
import re

xls = pd.ExcelFile(r"C:/Users/Adriano/Desktop/dataset.xlsx") #use r before absolute file path 

sheetX = xls.parse(0) #2 is the sheet number+1 thus if the file has only 1 sheet write 0 in paranthesis

k = len(sheetX['Latitude'])


d = dict()

for i in range(k):
    if(sheetX.index == i).any():
        sumTot = sheetX['CONTENTOR_TOTAL_LITROS'][i]
        lat = sheetX['Latitude'][i]
        lon = sheetX['Longitude'][i]
        tipoL = sheetX['CONTENTOR_RESÍDUO'][i]
        local = sheetX['PONTO_RECOLHA_LOCAL'][i]
        local = re.sub(r'\(.*\)','',local)
        local = re.sub(r'[0-9]+\s*: ','',local)
        list = []
        for j in range(i+1,k):
            if(sheetX.index == j).any():
                if sheetX['Latitude'][j] == lat and sheetX['Longitude'][j] == lon and sheetX['CONTENTOR_RESÍDUO'][j] == tipoL:
                    sumTot += sheetX['CONTENTOR_TOTAL_LITROS'][j]
                    list.append(j)
    
        sheetX = sheetX.drop(list)
        d.setdefault('Latitude', []).append(lat)
        d.setdefault('Longitude', []).append(lon)
        d.setdefault('PONTO_RECOLHA_LOCAL', []).append(local)
        d.setdefault('CONTENTOR_RESÍDUO', []).append(tipoL)
        d.setdefault('CONTENTOR_TOTAL_LITROS', []).append(sumTot)

df = pd.DataFrame(data=d)
df.to_excel(r'C:/Users/Adriano/Desktop/dataset1.xlsx')


