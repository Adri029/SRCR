import pandas as pd

xls = pd.ExcelFile(r"C:/Users/Adriano/Desktop/dataset1.xlsx") #use r before absolute file path 

sheetX = xls.parse(0) #2 is the sheet number+1 thus if the file has only 1 sheet write 0 in paranthesis

k = len(sheetX['Latitude'])


d = dict()

for i in range(k):
    if(sheetX.index == i).any():
        lat = sheetX['Latitude'][i]
        lon = sheetX['Longitude'][i]
        local = sheetX['PONTO_RECOLHA_LOCAL'][i]
        list = []
        for j in range(i+1,k):
            if(sheetX.index == j).any():
                if sheetX['Latitude'][j] == lat and sheetX['Longitude'][j] == lon:
                    list.append(j)
    
        sheetX = sheetX.drop(list)
        d.setdefault('Latitude', []).append(lat)
        d.setdefault('Longitude', []).append(lon)
        d.setdefault('PONTO_RECOLHA_LOCAL', []).append(local)

df = pd.DataFrame(data=d)
df.to_excel(r'C:/Users/Adriano/Desktop/datasetAux.xlsx')




