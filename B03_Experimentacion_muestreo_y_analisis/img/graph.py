import numpy as np
from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
from scipy.stats import uniform

plt.rcParams.update({'font.size': 12})

# FIGURA 1
with PdfPages('fig1A.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    labels = ['Caso 1', 'Peras', 'Caso 2', 'Manzanas', 'Caso 3', 'Bananas']
    a = [25, 32, 34, 20, 25, 42]
    x = np.arange(len(labels))
    fig, ax = plt.subplots()
    rects1 = ax.bar(x, a,  0.35, label='')
    plt.ylabel('Cantidad')
    ax.set_title('Casos y Frutas')
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    pdf.savefig()
    plt.close()

with PdfPages('fig1B.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    labels = ['Caso 1', 'Caso 2', 'Caso 3']
    a = [25, 34, 25]
    x = np.arange(len(labels))
    fig, ax = plt.subplots()
    rects1 = ax.bar(x, a,  0.35, label='')
    plt.ylabel('Cantidad')
    ax.set_title('Casos')
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    pdf.savefig()
    plt.close()

with PdfPages('fig1C.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    labels = ['Peras', 'Manzanas', 'Bananas']
    a = [32, 20, 42]
    x = np.arange(len(labels))
    fig, ax = plt.subplots()
    rects1 = ax.bar(x, a,  0.35, label='')
    plt.ylabel('Cantidad')
    ax.set_title('Frutas')
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    pdf.savefig()
    plt.close()

# FIGURA 2
a = list(map(lambda x : 2**x, range(0,50)))    
for i in range(0,50):
    a[i] = a[i] + i*10000

with PdfPages('fig2A.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    plt.plot(range(len(a)), a, 'r-')
    plt.title('Rendimiento')
    plt.xlabel('Cantidad de pixeles')
    plt.ylabel('Cantidad de ticks')
    pdf.savefig()
    plt.close()

with PdfPages('fig2B.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    plt.plot(range(len(a)), a, 'r-')
    plt.title('Rendimiento (log)')
    plt.xlabel('Cantidad de pixeles')
    plt.ylabel('Cantidad de ticks')
    plt.yscale('log')
    pdf.savefig()
    plt.close()

# FIGURA 3
labels = 'O0', '01', '02', '03', 'ASM'
sizes = [234, 50, 43, 32, 21]

with PdfPages('fig3A.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    explode = (0, 0, 0, 0, 0.2)  # only "explode" the slice 'ASM'
    fig, ax = plt.subplots()
    ax.pie(sizes, explode=explode, labels=labels, autopct='%1.1f%%', shadow=False, startangle=180)
    ax.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.
    ax.set_title('Comparación de Optimizaciones')
    pdf.savefig()
    plt.close()

with PdfPages('fig3B.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    x = np.arange(len(labels))
    fig, ax = plt.subplots()
    rects1 = ax.bar(x, sizes, 0.35, label='Rendimiento')
    ax.set_ylabel('Cantidad de Ticks (Millones)')
    ax.set_title('Comparación de Optimizaciones')
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    pdf.savefig()
    plt.close()

# FIGURA 4
x = [  0,   1,   2,   3,   4,   5,   6,   7]
y = [8.1, 6.5, 3.4, 2.1, 3.4, 4.5, 5.9, 6.1]
e1= [0.4, 0.8, 1.0, 0.3, 0.8, 0.5, 0.2, 0.1]
e2= [1.4, 2.8, 3.5, 3.3, 3.8, 2.5, 1.2, 1.1]

with PdfPages('fig4A.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    fig, ax = plt.subplots()
    ax.errorbar(x, y, lw=1, ls='-')
    plt.ylim((-2,10))
    plt.title('Busqueda del mínimo parámetro')
    plt.xlabel('Valor del parámetro')
    plt.ylabel('Relación entre A y B')
    pdf.savefig()
    plt.close()

with PdfPages('fig4B.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    fig, ax = plt.subplots()
    ax.errorbar(x, y, yerr=e2, lw=1, ls='-')
    plt.ylim((-2,10))
    plt.title('Busqueda del mínimo parámetro')
    plt.xlabel('Valor del parámetro')
    plt.ylabel('Relación entre A y B')
    pdf.savefig()
    plt.close()

with PdfPages('fig4C.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    fig, ax = plt.subplots()
    ax.errorbar(x, y, yerr=e1, lw=1, ls='-')
    plt.ylim((-2,10))
    plt.title('Busqueda del mínimo parámetro')
    plt.xlabel('Valor del parámetro')
    plt.ylabel('Relación entre A y B')
    pdf.savefig()
    plt.close()

# FIGURA 5
x = [  0,   1,   2,   3,   4,   5,   6,   7]
y1 = [103, 1032, 10014, 103240, 1001630, 13170000, 106283000, 1009742000]
y2 = [9420, 5444, 3556, 3013, 3425, 4034, 4314, 4132]
e1= [0.4, 0.8, 1.0, 0.3, 0.8, 0.5, 0.2, 0.1]
e2= [1.4, 2.8, 3.5, 3.3, 3.8, 2.5, 1.2, 1.1]

with PdfPages('fig5A.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    fig, ax = plt.subplots()
    ax.errorbar(x, y1, lw=1, ls='-')
    plt.title('Rendimiento según tamaño de la imagen')
    plt.xlabel('Tamaño de la imagen')
    plt.ylabel('Cantidad de Ticks')
    pdf.savefig()
    plt.close()

with PdfPages('fig5B.pdf') as pdf:
    plt.figure(figsize=(7, 5))
    fig, ax = plt.subplots()
    ax.errorbar(x, y2, lw=1, ls='-')
    plt.title('Rendimiento según tamaño de la imagen')
    plt.xlabel('Tamaño de la imagen')
    plt.ylabel('Ticks por pixel procesado')
    pdf.savefig()
    plt.close()
