<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 11.03.2017
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calculator</title>
    <link rel="stylesheet" type="text/css" href="../../static/css/calculator_style.css"/>
</head>

<body align="center">
<script src="../../static/js/vue.js"></script>
<script src="../../static/js/vue-resource.min.js"></script>
<script src="../../static/js/vue-router.js"></script>

<div id="app">

    <router-view></router-view>

</div>

<script type="vue/template" id="calculatorTemplate" style="text-align: left; width: 800px">
    <form>
        <h2 align="center">КАЛЬКУЛЯТОР РАСЧЕТА ПОДОХОДНОГО НАЛОГА
            С ФИЗИЧЕСКИХ ЛИЦ
            ЗА 2016 г.
            (для индивидуальных предпринимателей)
        </h2>
        <div style="text-align: left">
            <label>Период, за который производится расчет:</label>
            <select title="Квартал" id="scope" v-model="operation.period">
                <option value="3">Квартал</option>
                <option value="6">Полугодие</option>
                <option value="9">Девять месяцев</option>
                <option value="12">Год</option>
            </select>
        </div>
        <div style="text-align: left">
            <label>
                Сумма выручки от реализации товаров (работ, услуг),
                имущественных прав за выбранный период
                (без налога на добавленную стоимость), руб.
            </label>
            <input type="number" step="any" v-model="operation.amount_receipts">
        </div>
        <div style="text-align: left">
            <label>
                Сумма внереализационных доходов за выбранный период
                (без налога на добавленную стоимость), руб.
            </label>
            <input type="number" step="any" v-model="operation.amount_income">
        </div>
        <div style="text-align: left">
            <label>Наличие места основной работы:</label>
            <ul>
                <li>
                    <label>
                        <input type="radio" v-model="operation.job_availability" value="1" @click="show=false">да
                    </label>
                </li>
                <li>
                    <label>
                        <input type="radio" v-model="operation.job_availability" value="0" @click="show=true">нет
                    </label>
                </li>
            </ul>
        </div>

        <div v-show="show" style="text-align: left">
            <div>
                <label>Наличие права на льготы (инвалид I или II группы, инвалид с детства,
                    участник боевых действий на территории других государств и др.):
                </label>
                <ul>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.benefits_availability" name="benefits_availability" value="1">да
                        </label>
                    </li>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.benefits_availability" name="benefits_availability" value="0">нет
                        </label>
                    </li>
                </ul>

            </div>
            <div style="text-align: left">
                <label>Являетесь ли Вы вдовой (вдовцом),
                    одиноким родителем, приемным родителем,
                    опекуном или попечителем:</label>
                <ul>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.lonely" name="lonely" value="1">да
                        </label>
                    </li>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.lonely" name="lonely" value="0">нет
                        </label>
                    </li>
                </ul>
            </div>
            <div style="text-align: left">
                <label>Количество детей до 18 лет,
                    из них количество детей-инвалидов</label>
                <input type="number" onkeypress="isNumberKey(event)" id="number_child" v-model="operation.number_child">
                <input type="number" onkeypress="isNumberKey(event)" @keyup="check_child()" id="number_child_invalid" v-model="operation.number_child_invalid">

            </div>
            <div style="text-align: left">
                <label>Количество иждивенцев</label>
                <input type="number" onkeypress="isNumberKey(event)" v-model="operation.number_dependent">
            </div>
            <div style="text-align: left">
                <label>Сумма расходов за выбранный период по страховым взносам по договорам добровольного страхования жизни и дополнительной пенсии, заключенным
                    на срок не менее трех лет, а также по договорам добровольного
                    страхования медицинских расходов, руб.</label>
                <input type="number" step="any" v-model="operation.amount_contribution">
            </div>
            <div style="text-align: left">
                <label>Сумма расходов за выбранный период на
                    получение первого платного образования своего либо
                    близких родственников, руб.</label>
                <input type="number" step="any" v-model="operation.amount_education">
            </div>
            <div style="text-align: left">
                <label>Сумма расходов за выбранный период на строительство либо приобретение жилья
                    для нуждающихся в улучшении жилищных условий, руб.</label>
                <input type="number" step="any" v-model="operation.amount_building"><br />
            </div>
        </div>

        <div style="text-align: left">
            <label>Сумма расходов за выбранный период, связанных с осуществлением
                предпринимательской деятельности,</label>
            <input type="number" step="any" v-model="operation.amount_entrepreneurial_activity"><br />
        </div>
        <div style="text-align: left" v-show="show_result">

            <label><h3>РЕЗУЛЬТАТ:</h3></label>
            <h3 style="width: 90%">{{ operation.result }}</h3>
        </div>
        <div style="text-align: left">
            <label><button type="button">Все операции</button></label>
            <button type="button" @click="calculate">Рассчитать</button>
        </div>
    </form>
</script>

<script type="vue/template" id="operationsTemplate">
    <table>
        <thead>
            <tr>
                <th>
                    Период, за который производится расчет:
                </th>
                <th>
                    Сумма выручки от реализации товаров (работ, услуг),
                    имущественных прав за выбранный период
                    (без налога на добавленную стоимость), руб.
                </th>
                <th>
                    Сумма внереализационных доходов за выбранный период
                    (без налога на добавленную стоимость), руб.
                </th>
                <th>
                    Наличие места основной работы
                </th>
                <th>
                    Результат
                </th>
            </tr>

        </thead>
        <tbody>
            <template v-for="operation in operations">
                <tr>
                    <td>{{ operation.period }}</td>
                    <td>{{ operation.amount_receipts }}</td>
                    <td>{{ operation.amount_income }}</td>
                    <td>{{ operation.job_availability }}</td>
                    <td>{{ operation.result }}</td>
                </tr>
            </template>
        </tbody>
    </table>
</script>

<script>
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which:event.keyCode;

        if(charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;

    }

</script>
<script>
    Vue.http.options.emulateJSON = true;
    Vue.use(VueRouter);
    Vue.use(VueResource);

    var Operation = Vue.extend({
        template:'#operationsTemplate',
        data:function() {
            alert('OPERATIONS COMPONENT');
            this.$http.get("/operation").then(function(response){
                this.operations = response.data;
                alert('OPERATIONS');
                alert(operations[0].period);
            });
        }
    });

    var Calculator = Vue.extend({
        template:'#calculatorTemplate',
        data:function(){
            return {
                operation:{
                    period:6,
                    amount_receipts:0,
                    amount_income:0,
                    job_availability:0,
                    benefits_availability:1,
                    lonely: 0,
                    number_child: 0,
                    number_child_invalid: 0,
                    number_dependent: 0,
                    amount_contribution: 0,
                    amount_education:0,
                    amount_building:0,
                    amount_entrepreneurial_activity: 0
                },
                show: true,
                show_result: false

            };
        },
        methods: {
            calculate: function () {
                this.$http.post("/operation/new",this.operation).then(function(response) {
                    this.operation = response.data;
                    this.show_result = true;
                }, function(error){
                    alert('error ');
                });
            },
            check_child: function () {
                var number_child = document.getElementById("number_child").value;
                var number_child_invalid = document.getElementById("number_child_invalid").value;
                if (number_child_invalid > number_child) {
                    var n = parseInt(number_child_invalid.charAt(number_child_invalid.length - 1));
                    this.operation.number_child_invalid = (number_child_invalid - n) / 10;
                }
            }

        }
    });

    var router = new VueRouter({
        routes:[
            { path: '/', component: Calculator },
            { path: '/operation', component: Operation }
        ]
    });

    var app = new Vue({
        router: router
    }).$mount('#app');
</script>


</body>
</html>
