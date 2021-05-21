import pandas as pd

xls = pd.ExcelFile(r"C:/Users/Adriano/Desktop/datasetAux.xlsx") #use r before absolute file path 
xlsOrigin = pd.ExcelFile(r"C:/Users/Adriano/Desktop/localidades.xlsx")

sheetXOr = xlsOrigin.parse(0) #2 is the sheet number+1 thus if the file has only 1 sheet write 0 in paranthesis
sheetX = xls.parse(0)

k = len(sheetXOr['Latitude'])
l = len(sheetX['ID'])

d = dict()

for i in range(k):
    if(sheetXOr.index == i).any():
        lat = sheetXOr['Latitude'][i]
        lon = sheetXOr['Longitude'][i]
        local = sheetXOr['PONTO_RECOLHA_LOCAL'][i]

        for j in range(l):
            if(sheetX.index == j).any():
                if sheetX['PONTO_RECOLHA_LOCAL'][j] == local:
                    d.setdefault('ID', []).append(sheetX['ID'][j])
                    d.setdefault('Latitude', []).append(sheetXOr['Latitude'][i])
                    d.setdefault('Longitude',[]).append(sheetXOr['Longitude'][i])
                    break
        

df = pd.DataFrame(data=d)
df.to_excel(r'C:/Users/Adriano/Desktop/localizacoes.xlsx')

