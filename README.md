# ShinyApp simulador valor de la moneda
**Descripción:** Aplicación ShinyApp para el testeo del valor de la moneda en base al establecimiento de impuestos.

### Salud! 👋
* 👂 Autor: **Manuel Alén Sánchez**
* 🔭 Actividad profesional: **Estadística y BI**
* 📫 Contacto: manualen@protonmail.com

  ## 🚢 Proyecto:
  Una ShinyApp en ``R`` para permitir entender mejor cómo los impuestos determinan el valor del dinero. También podrían determinar el trabajo necesario para obtener la cantidad de moneda suficiente y necesaria para pagar los impuestos establecidos por un Estado.

  ### 📈 Formulación del valor de la moneda

  Para determinar el valor de la moneda, hemos empleado el siguiente modelo


  $$ V = \frac{s}{M \cdot (1 - t)} $$

Donde ``V`` es el valor de la moneda, ``s`` los bienes y servicios reales medido en unidades monetarias. Por otro lado, ``M`` será la masa monetaria y ``t`` sería le nivel de impuestos.

  ### 👀 Ejemplo de replicación
Se han utilizado datos de [Trading Economics](https://tradingeconomics.com/) para determinar el valor de varias monedas. Como ejemplo se va a mostrar lo que será el valor del euro (en España) y su comparación con el dólar.

| **País** | **Valor de la moneda** |
|------|-------|
| :es: | 1,46  |
| :us: | 1,69  |
| :es:/:us: | 0,86  |
| **Resultado a 11-03-2024 14:09** | 0,91 (🔻 -5,49%)  |

Se comprueba como el error es mínimo con un modelo básico y la obtención de los datos mediante un servicio que no nos permite saber con precisión todos los decimales o el valor completo al mostrarnos los datos del tipo X Billion.

De esta forma, para la ShinyApp realizamos, por un lado:

* 📉 Gráfica que muestra cómo la masa monetaria, a mayor nivel de impuestos, se reduce.
* 📈 Gráfica que muestra cómo a mayor nivel de impuestos, mayor será la demanda de moneda para simplemente mantener el nivel de masa monetaria inicial.

También añadimos un slicer para que el usuario pueda especificar la cantidad de masa monetaria que habría en la economía en cuestión.

Para la determinación de la masa monetaria de la primera gráfica, se hace uso de:

$$ M \cdot (1 - t) $$

Mientras que, para la segunda gráfica se hace uso de:

$$  \frac{M}{1 - t} $$.

El resultado final puede verse en el [simulador publicado](https://n802zc-manu-al0n.shinyapps.io/sim_ValorDinero/)
