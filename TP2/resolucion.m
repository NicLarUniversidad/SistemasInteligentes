# Se realizó un perceptrón que aprende la función boolean AND recibiendo 3 entradas.

# Se probaron diferentes velocidades de aprendizajes.

function x = calcular_correccion(valor_actual, valor_maximo=1, alpha=0.1)
  # Alfa es la velocidad de aprendizaje
  valor_medio = valor_maximo / 2
  salida =  valor_actual*alpha - valor_medio
  if (salida < 0)
    salida = valor_actual*alpha
  endif
  x = salida
endfunction

function x = calcular_indices(tabla, valor_a, valor_b, valor_c)
  x = 0
  for i = 1:rows(tabla)
    if ((tabla(i,1)==valor_a) && (tabla(i,2)==valor_b) && (tabla(i,3)==valor_c))
      x = i
    endif
  endfor
endfunction

function w = entrenar(tabla, conjunto_entranamiento, alpha=0.1)
  

  for i = 1:rows(conjunto_entranamiento)
      
      x = calcular_indices(tabla,conjunto_entranamiento(i,1),conjunto_entranamiento(i,2),conjunto_entranamiento(i,3))
      
      correccion = calcular_correccion(tabla(x,4), 1, alpha)
      if (conjunto_entranamiento(i,4) == 1)
        tabla(x,4) = tabla(x,4) + correccion
        for i = 1:rows(tabla)
          if (i!=x)
            tabla(i,4) = tabla(i,4) - (correccion/7)
          endif
        endfor
      else
        tabla(x,4) = tabla(x,4) - correccion
        for i = 1:rows(tabla)
          if (i!=x)
            tabla(i,4) = tabla(i,4) + (correccion/7)
          endif
        endfor
      endif
  endfor
    
  w = tabla

endfunction

function tabla_graf = convertir_tabla(tabla)
    tabla_graf = [0;0;0;0]
    tabla_graf(1) = tabla(1,4)
    tabla_graf(2) = tabla(2,4)
    tabla_graf(3) = tabla(3,4)
    tabla_graf(4) = tabla(4,4)
    tabla_graf(5) = tabla(5,4)
    tabla_graf(6) = tabla(6,4)
    tabla_graf(7) = tabla(7,4)
    tabla_graf(8) = tabla(8,4)
endfunction


conjunto_entranamiento = [
  0, 1, 0, 0;
  1, 1, 1, 1;
  0, 1, 1, 0;
  0, 1, 0, 0;
  1, 1, 1, 1;
  0, 1, 1, 0;
  1, 0, 1, 0;
  1, 0, 0, 0;
  0, 0, 0, 0;
  0, 0, 1, 0;
  0, 1, 0, 0;
  0, 1, 1, 0;
  1, 0, 0, 0;
  1, 0, 1, 0;
  1, 1, 0, 0;
  1, 1, 1, 0
]

#Probabilidades de las 8 combinaciones
tabla = [0,0,0,0.125;0,1,0,0.125;1,0,0,0.125;1,1,0,0.125;0,0,1,0.125;0,1,1,0.125;1,0,1,0.125;1,1,1,0.125]

fprintf(['Probabilidades de que la salida sea un 1 para las 4 entradas posibles iniciales para el preceptron \n']);
bar(tabla(1:end,4))
title  ("Probabilidades iniciales que una salida devuelva un 1");
waitforbuttonpress()
# Velocidad de aprendizaje por defecto
tabla_1 = entrenar(tabla, conjunto_entranamiento)
# Velocidad de aprendizaje con valor 1, mayor a la que puse por defecto
tabla_2 = entrenar(tabla, conjunto_entranamiento,1)
# Velocidad de aprendizaje con valor 0.01, menor a la que puse por defecto
tabla_3 = entrenar(tabla, conjunto_entranamiento,0.01)

#Probabilidades luego de entrenar
fprintf(['Probabilidades luego de entrenar al perceptron con la velocidad de aprendizaje que eleg? arbitrariamente como valor por defecto\n']);
bar(convertir_tabla(tabla_1))
title  ("Probabilidades que una salida devuelva un 1, luego de entrenar");
waitforbuttonpress()
fprintf(['Probabilidades luego de entrenar al perceptron una velocidad de aprendizaje igual a 1\n']);
bar(convertir_tabla(tabla_2))
title  ("Probabilidades que una salida devuelva un 1, luego de entrenar");
waitforbuttonpress()
fprintf(['Probabilidades luego de entrenar al perceptron una velocidad de aprendizaje igual a 0.01\n']);
bar(convertir_tabla(tabla_3))
title  ("Probabilidades que una salida devuelva un 1, luego de entrenar");
