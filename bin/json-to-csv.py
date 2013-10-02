# tomar archivo
# pasar a objeto
# si es arreglo ya esta
# si es mapa, buscar valor que sea arreglo, y hacer ese, o el argumento pasado
# para cada elemento, si es mapa, recursivamente meterse para generar rows con titulo de clave previa

def myprint(d):
  for k, v in d.iteritems():
    if isinstance(v, dict):
      myprint(v)
    else:
      print "{0} : {1}".format(k, v)
