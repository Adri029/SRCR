import pandas as pd

xls = pd.ExcelFile(r"C:/Users/Adriano/Desktop/datasetAux.xlsx") #use r before absolute file path 
xlsOrigin = pd.ExcelFile(r"C:/Users/Adriano/Desktop/dataset1.xlsx")

sheetXOr = xlsOrigin.parse(0) #2 is the sheet number+1 thus if the file has only 1 sheet write 0 in paranthesis
sheetX = xls.parse(0)

k = len(sheetXOr['Latitude'])
l = len(sheetX['Latitude'])

d = dict()

for i in range(k):
    if(sheetXOr.index == i).any():
        lat = sheetXOr['Latitude'][i]
        lon = sheetXOr['Longitude'][i]

        for j in range(l):
            if(sheetX.index == j).any():
                if sheetX['Latitude'][j] == lat and sheetX['Longitude'][j] == lon:
                    d.setdefault('ID', []).append(sheetX['ID'][j])
                    d.setdefault('CONTENTOR_RESÍDUO', []).append(sheetXOr['CONTENTOR_RESÍDUO'][i])
                    d.setdefault('CONTENTOR_TOTAL_LITROS',[]).append(sheetXOr['CONTENTOR_TOTAL_LITROS'][i])
                    break
        

df = pd.DataFrame(data=d)
df.to_excel(r'C:/Users/Adriano/Desktop/tiposLixo.xlsx')


