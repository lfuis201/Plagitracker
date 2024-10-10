﻿using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using PlagiTracker.Data.DataAccess;
using PlagiTracker.Data.Entities;
using PlagiTracker.Data.Requests;
using PlagiTracker.Services.FileServices;
using PlagiTracker.Services.SeleniumServices;
using PlagiTracker.WebAPI.HangFire;
using System.Text;

namespace PlagiTracker.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssignmentController : ControllerBase
    {
        private readonly DataContext _context;

        public AssignmentController(DataContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("Create")]
        public async Task<ActionResult> Create(AssignmentRequest assignmentRequest)
        {
            if(assignmentRequest.SubmissionDate.ToUniversalTime() < DateTime.UtcNow)
            {
                return BadRequest("The submission date must be greater than the current date.");
            }

            var id = Guid.NewGuid();
            await _context!.Assignments!.AddAsync(new Assignment()
            {
                Id = id,
                Description = assignmentRequest.Description,
                Title = assignmentRequest.Title,
                //Tiempo universal coordinado (UTC)
                SubmissionDate = assignmentRequest.SubmissionDate,
                CourseId = assignmentRequest.CourseId
            });

            await _context.SaveChangesAsync();
            return Ok(id);
        }

        [HttpPost]
        [Route("SavePlagiarismReport")]
        public async Task<ActionResult> SavePlagiarismReport()
        {
            string json = "{\"1979d2a7-de35-4d83-9aa9-857171cba7fa\":{\"Id\":\"1979d2a7-de35-4d83-9aa9-857171cba7fa\",\"FirstName\":\"Pedro\",\"LastName\":\"Picapiedra\",\"SubmissionId\":\"bd755547-68fc-4094-8f87-8b65797d668e\",\"Url\":\"https://www.covid.io/p/0dc699a0-6033-4bb6-b46c-15d238277749\",\"Codes\":{},\"State\":2,\"PlagiResults\":[]},\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\":{\"Id\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"FirstName\":\"Ben\",\"LastName\":\"Tennyson\",\"SubmissionId\":\"6e701991-2a14-4493-a170-f4fe910e9c4a\",\"Url\":\"https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700\",\"Codes\":{\"Calculadora.java\":\"package com.example;\\n\\npublic class Calculadora {\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\nif (denominador == 0) {\\nthrow new DivisionPorCeroException(\\\"Error: División por cero no permitida.\\\");\\n}\\nreturn (double) numerador / denominador;\\n}\\n\\npublic static void main(String[] args) {\\ntry {\\nSystem.out.println(\\\"Resultado: \\\" + dividir(10, 0));\\n} catch (DivisionPorCeroException e) {\\nSystem.err.println(e.getMessage());\\n}\\n}\\n}\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\",\"DivisionPorCeroException.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\npublic class DivisionPorCeroException extends Exception {\\npublic DivisionPorCeroException(String mensaje) {\\nsuper(mensaje);\\n}\\n}\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\",\"Main.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\nclass Main {\\n\\npublic static void main(String[] args) {\\n\\nSystem.out.println(\\\"Hello World!\\\");\\n}\\n}\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":82,\"Coincidences\":82,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.3942307692307692,\"JaccardSimilitude\":39.42,\"Similitud_Levenshtein\":26.08695652173913,\"LevenshteinSimilitude\":26.09,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.2676470588235294,\"JaccardSimilitude\":26.76,\"Similitud_Levenshtein\":51.61290322580645,\"LevenshteinSimilitude\":51.61,\"Similitud_Semantica\":0.7714285714285715,\"SemanticSimilitude\":77.14},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.5384615384615384,\"JaccardSimilitude\":53.85,\"Similitud_Levenshtein\":30.434782608695656,\"LevenshteinSimilitude\":30.43,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":95,\"Coincidences\":95,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.3275862068965517,\"JaccardSimilitude\":32.76,\"Similitud_Levenshtein\":56.25,\"LevenshteinSimilitude\":56.25,\"Similitud_Semantica\":0.8285714285714285,\"SemanticSimilitude\":82.86},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1393258426966292,\"JaccardSimilitude\":13.93,\"Similitud_Levenshtein\":19.047619047619047,\"LevenshteinSimilitude\":19.05,\"Similitud_Semantica\":0.8,\"SemanticSimilitude\":80.0},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.09494640122511486,\"JaccardSimilitude\":9.49,\"Similitud_Levenshtein\":68.88888888888889,\"LevenshteinSimilitude\":68.89,\"Similitud_Semantica\":0.6363636363636364,\"SemanticSimilitude\":63.64},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10961214165261383,\"JaccardSimilitude\":10.96,\"Similitud_Levenshtein\":54.700854700854705,\"LevenshteinSimilitude\":54.7,\"Similitud_Semantica\":0.426829268292683,\"SemanticSimilitude\":42.68},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.20253164556962025,\"JaccardSimilitude\":20.25,\"Similitud_Levenshtein\":42.465753424657535,\"LevenshteinSimilitude\":42.47,\"Similitud_Semantica\":0.3153153153153153,\"SemanticSimilitude\":31.53},{\"Coincidencias\":80,\"Coincidences\":80,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.17467248908296942,\"JaccardSimilitude\":17.47,\"Similitud_Levenshtein\":25.64102564102564,\"LevenshteinSimilitude\":25.64,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":89,\"Coincidences\":89,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.15084745762711865,\"JaccardSimilitude\":15.08,\"Similitud_Levenshtein\":36.36363636363637,\"LevenshteinSimilitude\":36.36,\"Similitud_Semantica\":0.9642857142857143,\"SemanticSimilitude\":96.43},{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.17592592592592593,\"JaccardSimilitude\":17.59,\"Similitud_Levenshtein\":30.76923076923077,\"LevenshteinSimilitude\":30.77,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":79,\"Coincidences\":79,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.14259927797833935,\"JaccardSimilitude\":14.26,\"Similitud_Levenshtein\":35.08771929824561,\"LevenshteinSimilitude\":35.09,\"Similitud_Semantica\":0.9655172413793104,\"SemanticSimilitude\":96.55},{\"Coincidencias\":346,\"Coincidences\":346,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.8459657701711492,\"JaccardSimilitude\":84.6,\"Similitud_Levenshtein\":82.14285714285714,\"LevenshteinSimilitude\":82.14,\"Similitud_Semantica\":1.0,\"SemanticSimilitude\":100.0},{\"Coincidencias\":88,\"Coincidences\":88,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10057142857142858,\"JaccardSimilitude\":10.06,\"Similitud_Levenshtein\":24.096385542168676,\"LevenshteinSimilitude\":24.1,\"Similitud_Semantica\":0.509090909090909,\"SemanticSimilitude\":50.91},{\"Coincidencias\":133,\"Coincidences\":133,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.17205692108667528,\"JaccardSimilitude\":17.21,\"Similitud_Levenshtein\":18.181818181818183,\"LevenshteinSimilitude\":18.18,\"Similitud_Semantica\":0.3414634146341463,\"SemanticSimilitude\":34.15},{\"Coincidencias\":77,\"Coincidences\":77,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1397459165154265,\"JaccardSimilitude\":13.97,\"Similitud_Levenshtein\":14.388489208633093,\"LevenshteinSimilitude\":14.39,\"Similitud_Semantica\":0.25225225225225223,\"SemanticSimilitude\":25.23},{\"Coincidencias\":34,\"Coincidences\":34,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.13229571984435798,\"JaccardSimilitude\":13.23,\"Similitud_Levenshtein\":22.22222222222222,\"LevenshteinSimilitude\":22.22,\"Similitud_Semantica\":0.32352941176470584,\"SemanticSimilitude\":32.35},{\"Coincidencias\":47,\"Coincidences\":47,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.12207792207792208,\"JaccardSimilitude\":12.21,\"Similitud_Levenshtein\":49.18032786885246,\"LevenshteinSimilitude\":49.18,\"Similitud_Semantica\":0.7941176470588236,\"SemanticSimilitude\":79.41},{\"Coincidencias\":31,\"Coincidences\":31,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.13478260869565217,\"JaccardSimilitude\":13.48,\"Similitud_Levenshtein\":17.77777777777778,\"LevenshteinSimilitude\":17.78,\"Similitud_Semantica\":0.32352941176470584,\"SemanticSimilitude\":32.35},{\"Coincidencias\":40,\"Coincidences\":40,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.11560693641618497,\"JaccardSimilitude\":11.56,\"Similitud_Levenshtein\":47.61904761904761,\"LevenshteinSimilitude\":47.62,\"Similitud_Semantica\":0.8529411764705882,\"SemanticSimilitude\":85.29},{\"Coincidencias\":95,\"Coincidences\":95,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.23002421307506055,\"JaccardSimilitude\":23.0,\"Similitud_Levenshtein\":32.25806451612903,\"LevenshteinSimilitude\":32.26,\"Similitud_Semantica\":0.8235294117647058,\"SemanticSimilitude\":82.35},{\"Coincidencias\":28,\"Coincidences\":28,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.040697674418604654,\"JaccardSimilitude\":4.07,\"Similitud_Levenshtein\":60.67415730337079,\"LevenshteinSimilitude\":60.67,\"Similitud_Semantica\":0.6181818181818182,\"SemanticSimilitude\":61.82},{\"Coincidencias\":38,\"Coincidences\":38,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.061191626409017714,\"JaccardSimilitude\":6.12,\"Similitud_Levenshtein\":46.55172413793103,\"LevenshteinSimilitude\":46.55,\"Similitud_Semantica\":0.41463414634146345,\"SemanticSimilitude\":41.46},{\"Coincidencias\":28,\"Coincidences\":28,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.07932011331444759,\"JaccardSimilitude\":7.93,\"Similitud_Levenshtein\":37.24137931034483,\"LevenshteinSimilitude\":37.24,\"Similitud_Semantica\":0.3063063063063063,\"SemanticSimilitude\":30.63}]},\"239e66d0-16c3-4ce4-b321-058b64269f5e\":{\"Id\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"FirstName\":\"Khvicha\",\"LastName\":\"Kvaratskhelia\",\"SubmissionId\":\"31edb16a-feb4-4cab-812c-e8a4bdb6ad45\",\"Url\":\"https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee\",\"Codes\":{\"HelloCodiva.java\":\"\\npackage com.example;\\n\\nclass HelloCodiva {\\npublic static void main(String[] args) {\\nint a = 15;\\nint b = 20; // will generate an error\\nint c = 654;\\nSystem.out.println(a+b+c);\\n}\\n}\\n\",\"Main.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\npublic class Main {\\npublic static void main(String[] args) {\\nint myNum = 5;               // integer (whole number)\\nfloat myFloatNum = 5.99f;    // floating point number\\nchar myLetter = 'D';         // character\\nboolean myBool = true;       // boolean\\nString myText = \\\"Hello\\\";     // String\\nSystem.out.println(myNum);\\nSystem.out.println(myFloatNum);\\nSystem.out.println(myLetter);\\nSystem.out.println(myBool);\\nSystem.out.println(myText);\\n}\\n}\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":89,\"Coincidences\":89,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.15084745762711865,\"JaccardSimilitude\":15.08,\"Similitud_Levenshtein\":36.36363636363637,\"LevenshteinSimilitude\":36.36,\"Similitud_Semantica\":0.9642857142857143,\"SemanticSimilitude\":96.43},{\"Coincidencias\":47,\"Coincidences\":47,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.12207792207792208,\"JaccardSimilitude\":12.21,\"Similitud_Levenshtein\":49.18032786885246,\"LevenshteinSimilitude\":49.18,\"Similitud_Semantica\":0.7941176470588236,\"SemanticSimilitude\":79.41},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.2676470588235294,\"JaccardSimilitude\":26.76,\"Similitud_Levenshtein\":51.61290322580645,\"LevenshteinSimilitude\":51.61,\"Similitud_Semantica\":0.7714285714285715,\"SemanticSimilitude\":77.14},{\"Coincidencias\":84,\"Coincidences\":84,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.22641509433962265,\"JaccardSimilitude\":22.64,\"Similitud_Levenshtein\":26.31578947368421,\"LevenshteinSimilitude\":26.32,\"Similitud_Semantica\":0.40740740740740744,\"SemanticSimilitude\":40.74},{\"Coincidencias\":247,\"Coincidences\":247,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.7417417417417418,\"JaccardSimilitude\":74.17,\"Similitud_Levenshtein\":85.71428571428571,\"LevenshteinSimilitude\":85.71,\"Similitud_Semantica\":0.9310344827586207,\"SemanticSimilitude\":93.1},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.11428571428571428,\"JaccardSimilitude\":11.43,\"Similitud_Levenshtein\":21.818181818181817,\"LevenshteinSimilitude\":21.82,\"Similitud_Semantica\":0.9642857142857143,\"SemanticSimilitude\":96.43},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08591885441527446,\"JaccardSimilitude\":8.59,\"Similitud_Levenshtein\":36.58536585365854,\"LevenshteinSimilitude\":36.59,\"Similitud_Semantica\":0.49090909090909096,\"SemanticSimilitude\":49.09},{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.0978120978120978,\"JaccardSimilitude\":9.78,\"Similitud_Levenshtein\":27.522935779816514,\"LevenshteinSimilitude\":27.52,\"Similitud_Semantica\":0.3292682926829268,\"SemanticSimilitude\":32.93},{\"Coincidencias\":66,\"Coincidences\":66,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.12966601178781925,\"JaccardSimilitude\":12.97,\"Similitud_Levenshtein\":20.28985507246377,\"LevenshteinSimilitude\":20.29,\"Similitud_Semantica\":0.2432432432432432,\"SemanticSimilitude\":24.32},{\"Coincidencias\":80,\"Coincidences\":80,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.17467248908296942,\"JaccardSimilitude\":17.47,\"Similitud_Levenshtein\":25.64102564102564,\"LevenshteinSimilitude\":25.64,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":34,\"Coincidences\":34,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.13229571984435798,\"JaccardSimilitude\":13.23,\"Similitud_Levenshtein\":22.22222222222222,\"LevenshteinSimilitude\":22.22,\"Similitud_Semantica\":0.32352941176470584,\"SemanticSimilitude\":32.35},{\"Coincidencias\":82,\"Coincidences\":82,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.3942307692307692,\"JaccardSimilitude\":39.42,\"Similitud_Levenshtein\":26.08695652173913,\"LevenshteinSimilitude\":26.09,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":94,\"Coincidences\":94,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.42727272727272725,\"JaccardSimilitude\":42.73,\"Similitud_Levenshtein\":54.54545454545454,\"LevenshteinSimilitude\":54.55,\"Similitud_Semantica\":1.0,\"SemanticSimilitude\":100.0},{\"Coincidencias\":86,\"Coincidences\":86,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.24362606232294617,\"JaccardSimilitude\":24.36,\"Similitud_Levenshtein\":30.0,\"LevenshteinSimilitude\":30.0,\"Similitud_Semantica\":0.3793103448275862,\"SemanticSimilitude\":37.93},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.12424849699398798,\"JaccardSimilitude\":12.42,\"Similitud_Levenshtein\":10.256410256410255,\"LevenshteinSimilitude\":10.26,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":61,\"Coincidences\":61,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08615819209039548,\"JaccardSimilitude\":8.62,\"Similitud_Levenshtein\":15.151515151515152,\"LevenshteinSimilitude\":15.15,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10046367851622875,\"JaccardSimilitude\":10.05,\"Similitud_Levenshtein\":10.75268817204301,\"LevenshteinSimilitude\":10.75,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.16981132075471697,\"JaccardSimilitude\":16.98,\"Similitud_Levenshtein\":6.557377049180328,\"LevenshteinSimilitude\":6.56,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91}]},\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\":{\"Id\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"FirstName\":\"Khabib \",\"LastName\":\"Nurmagomedov\",\"SubmissionId\":\"e0d30fd2-1027-4af3-be3b-238a579dacb8\",\"Url\":\"https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8\",\"Codes\":{\"HelloCodiva.java\":\"package com.example;\\n\\nclass HelloCodiva {\\n\\npublic static void main(String[] args) {\\n\\nString greeting = \\\"Hello World\\\";\\nSystem.out.println(greeting);\\n\\n}\\n}\\n\",\"Main.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\nclass Main {\\npublic static void main(String[] args) {\\nchar myLetter = 'D';         // character\\nboolean myBool = true;       // boolean\\nString myText = \\\"Hello\\\";     // String\\n\\nint myNum = 5;\\nfloat myFloatNum = 5.99f;\\n\\nSystem.out.println(myNum);\\nSystem.out.println(myFloatNum);\\nSystem.out.println(myLetter);\\nSystem.out.println(myBool);\\nSystem.out.println(myText);\\n}\\n}\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.17592592592592593,\"JaccardSimilitude\":17.59,\"Similitud_Levenshtein\":30.76923076923077,\"LevenshteinSimilitude\":30.77,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":31,\"Coincidences\":31,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.13478260869565217,\"JaccardSimilitude\":13.48,\"Similitud_Levenshtein\":17.77777777777778,\"LevenshteinSimilitude\":17.78,\"Similitud_Semantica\":0.32352941176470584,\"SemanticSimilitude\":32.35},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.5384615384615384,\"JaccardSimilitude\":53.85,\"Similitud_Levenshtein\":30.434782608695656,\"LevenshteinSimilitude\":30.43,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":94,\"Coincidences\":94,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.42727272727272725,\"JaccardSimilitude\":42.73,\"Similitud_Levenshtein\":54.54545454545454,\"LevenshteinSimilitude\":54.55,\"Similitud_Semantica\":1.0,\"SemanticSimilitude\":100.0},{\"Coincidencias\":84,\"Coincidences\":84,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.22641509433962265,\"JaccardSimilitude\":22.64,\"Similitud_Levenshtein\":26.31578947368421,\"LevenshteinSimilitude\":26.32,\"Similitud_Semantica\":0.40740740740740744,\"SemanticSimilitude\":40.74},{\"Coincidencias\":59,\"Coincidences\":59,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.125,\"JaccardSimilitude\":12.5,\"Similitud_Levenshtein\":25.64102564102564,\"LevenshteinSimilitude\":25.64,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08836524300441827,\"JaccardSimilitude\":8.84,\"Similitud_Levenshtein\":21.21212121212121,\"LevenshteinSimilitude\":21.21,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10355987055016182,\"JaccardSimilitude\":10.36,\"Similitud_Levenshtein\":15.053763440860216,\"LevenshteinSimilitude\":15.05,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1744186046511628,\"JaccardSimilitude\":17.44,\"Similitud_Levenshtein\":9.836065573770492,\"LevenshteinSimilitude\":9.84,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91},{\"Coincidencias\":79,\"Coincidences\":79,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.14259927797833935,\"JaccardSimilitude\":14.26,\"Similitud_Levenshtein\":35.08771929824561,\"LevenshteinSimilitude\":35.09,\"Similitud_Semantica\":0.9655172413793104,\"SemanticSimilitude\":96.55},{\"Coincidencias\":40,\"Coincidences\":40,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.11560693641618497,\"JaccardSimilitude\":11.56,\"Similitud_Levenshtein\":47.61904761904761,\"LevenshteinSimilitude\":47.62,\"Similitud_Semantica\":0.8529411764705882,\"SemanticSimilitude\":85.29},{\"Coincidencias\":95,\"Coincidences\":95,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.3275862068965517,\"JaccardSimilitude\":32.76,\"Similitud_Levenshtein\":56.25,\"LevenshteinSimilitude\":56.25,\"Similitud_Semantica\":0.8285714285714285,\"SemanticSimilitude\":82.86},{\"Coincidencias\":86,\"Coincidences\":86,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.24362606232294617,\"JaccardSimilitude\":24.36,\"Similitud_Levenshtein\":30.0,\"LevenshteinSimilitude\":30.0,\"Similitud_Semantica\":0.3793103448275862,\"SemanticSimilitude\":37.93},{\"Coincidencias\":247,\"Coincidences\":247,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.7417417417417418,\"JaccardSimilitude\":74.17,\"Similitud_Levenshtein\":85.71428571428571,\"LevenshteinSimilitude\":85.71,\"Similitud_Semantica\":0.9310344827586207,\"SemanticSimilitude\":93.1},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10810810810810811,\"JaccardSimilitude\":10.81,\"Similitud_Levenshtein\":21.052631578947366,\"LevenshteinSimilitude\":21.05,\"Similitud_Semantica\":0.9655172413793104,\"SemanticSimilitude\":96.55},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08135168961201501,\"JaccardSimilitude\":8.14,\"Similitud_Levenshtein\":40.476190476190474,\"LevenshteinSimilitude\":40.48,\"Similitud_Semantica\":0.5272727272727273,\"SemanticSimilitude\":52.73},{\"Coincidencias\":70,\"Coincidences\":70,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.09497964721845319,\"JaccardSimilitude\":9.5,\"Similitud_Levenshtein\":30.630630630630627,\"LevenshteinSimilitude\":30.63,\"Similitud_Semantica\":0.35365853658536583,\"SemanticSimilitude\":35.37},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1351931330472103,\"JaccardSimilitude\":13.52,\"Similitud_Levenshtein\":22.857142857142858,\"LevenshteinSimilitude\":22.86,\"Similitud_Semantica\":0.26126126126126126,\"SemanticSimilitude\":26.13}]},\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\":{\"Id\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"FirstName\":\"Ramzan\",\"LastName\":\"Kadyrov\",\"SubmissionId\":\"b6c2d5e1-33c4-4048-820b-03d25fe674b9\",\"Url\":\"https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3\",\"Codes\":{\"Calculadora.java\":\"class DivisionPorCeroException extends Exception {\\npublic DivisionPorCeroException(String mensaje) {\\nsuper(mensaje);\\n}\\n}\\n\\npublic class Calculadora {\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\nif (denominador == 0) {\\nthrow new DivisionPorCeroException(\\\"Error: División por cero no permitida.\\\");\\n}\\nreturn (double) numerador / denominador;\\n}\\n\\npublic static void main(String[] args) {\\ntry {\\nSystem.out.println(\\\"Resultado: \\\" + dividir(10, 0));\\n} catch (DivisionPorCeroException e) {\\nSystem.err.println(e.getMessage());\\n}\\n}\\n}\\n\\n\\n\\n\\n\\n\\n\",\"Diccionario.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nimport java.util.HashMap;\\n\\npublic class Diccionario {\\npublic static void main(String[] args) {\\n// Crear un HashMap para almacenar palabras y sus definiciones\\nHashMap<String, String> diccionario = new HashMap<>();\\n\\n// Añadir elementos al diccionario\\ndiccionario.put(\\\"Java\\\", \\\"Lenguaje de programación orientado a objetos.\\\");\\ndiccionario.put(\\\"Python\\\", \\\"Lenguaje de programación de alto nivel.\\\");\\ndiccionario.put(\\\"HTML\\\", \\\"Lenguaje de marcado para crear páginas web.\\\");\\n\\n// Buscar y mostrar una definición\\nString palabra = \\\"Java\\\";\\nif (diccionario.containsKey(palabra)) {\\nSystem.out.println(palabra + \\\": \\\" + diccionario.get(palabra));\\n} else {\\nSystem.out.println(\\\"Palabra no encontrada en el diccionario.\\\");\\n}\\n\\n// Mostrar todas las palabras en el diccionario\\nSystem.out.println(\\\"\\\\nPalabras en el diccionario:\\\");\\nfor (String key : diccionario.keySet()) {\\nSystem.out.println(key + \\\": \\\" + diccionario.get(key));\\n}\\n}\\n}\\n\\n\\n\\n\",\"FileHandler.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nimport java.io.*;\\n\\npublic class FileHandler {\\npublic static void main(String[] args) {\\nString fileName = \\\"example.txt\\\";\\n\\n// Escribir en un archivo\\ntry (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {\\nwriter.write(\\\"Este es un ejemplo de escritura en archivo.\\\");\\nwriter.newLine();\\nwriter.write(\\\"Java es genial para manejar archivos.\\\");\\nSystem.out.println(\\\"Escritura en archivo completada.\\\");\\n} catch (IOException e) {\\nSystem.err.println(\\\"Error al escribir en el archivo: \\\" + e.getMessage());\\n}\\n\\n// Leer desde un archivo\\ntry (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {\\nString line;\\nwhile ((line = reader.readLine()) != null) {\\nSystem.out.println(\\\"Contenido del archivo: \\\" + line);\\n}\\n} catch (IOException e) {\\nSystem.err.println(\\\"Error al leer el archivo: \\\" + e.getMessage());\\n}\\n}\\n}\\n\\n\\n\\n\",\"TestAnimales.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nclass Animal {\\npublic void sonido() {\\nSystem.out.println(\\\"El animal hace un sonido\\\");\\n}\\n}\\n\\nclass Perro extends Animal {\\n@Override\\npublic void sonido() {\\nSystem.out.println(\\\"El perro ladra\\\");\\n}\\n}\\n\\nclass Gato extends Animal {\\n@Override\\npublic void sonido() {\\nSystem.out.println(\\\"El gato maúlla\\\");\\n}\\n}\\n\\npublic class TestAnimales {\\npublic static void main(String[] args) {\\nAnimal miPerro = new Perro();\\nAnimal miGato = new Gato();\\n\\nmiPerro.sonido();\\nmiGato.sonido();\\n}\\n}\\n\\n\\n\",\"asf.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nclass asf {\\npublic static void main(String[] args) {\\n\\nSystem.out.println(\\\"Hello Codiva\\\");\\n\\n}\\n}\\n\\n\",\"asfsadasd.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nclass asfsadasd {\\npublic static void main(String[] args) {\\n\\nSystem.out.println(\\\"Hello Codiva\\\");\\n\\n}\\n}\\n\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":346,\"Coincidences\":346,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.8459657701711492,\"JaccardSimilitude\":84.6,\"Similitud_Levenshtein\":82.14285714285714,\"LevenshteinSimilitude\":82.14,\"Similitud_Semantica\":1.0,\"SemanticSimilitude\":100.0},{\"Coincidencias\":95,\"Coincidences\":95,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.23002421307506055,\"JaccardSimilitude\":23.0,\"Similitud_Levenshtein\":32.25806451612903,\"LevenshteinSimilitude\":32.26,\"Similitud_Semantica\":0.8235294117647058,\"SemanticSimilitude\":82.35},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.1393258426966292,\"JaccardSimilitude\":13.93,\"Similitud_Levenshtein\":19.047619047619047,\"LevenshteinSimilitude\":19.05,\"Similitud_Semantica\":0.8,\"SemanticSimilitude\":80.0},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.12424849699398798,\"JaccardSimilitude\":12.42,\"Similitud_Levenshtein\":10.256410256410255,\"LevenshteinSimilitude\":10.26,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.11428571428571428,\"JaccardSimilitude\":11.43,\"Similitud_Levenshtein\":21.818181818181817,\"LevenshteinSimilitude\":21.82,\"Similitud_Semantica\":0.9642857142857143,\"SemanticSimilitude\":96.43},{\"Coincidencias\":59,\"Coincidences\":59,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.125,\"JaccardSimilitude\":12.5,\"Similitud_Levenshtein\":10.256410256410255,\"LevenshteinSimilitude\":10.26,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.10810810810810811,\"JaccardSimilitude\":10.81,\"Similitud_Levenshtein\":21.052631578947366,\"LevenshteinSimilitude\":21.05,\"Similitud_Semantica\":0.9655172413793104,\"SemanticSimilitude\":96.55},{\"Coincidencias\":77,\"Coincidences\":77,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.1397459165154265,\"JaccardSimilitude\":13.97,\"Similitud_Levenshtein\":14.388489208633093,\"LevenshteinSimilitude\":14.39,\"Similitud_Semantica\":0.25225225225225223,\"SemanticSimilitude\":25.23},{\"Coincidencias\":28,\"Coincidences\":28,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.07932011331444759,\"JaccardSimilitude\":7.93,\"Similitud_Levenshtein\":37.24137931034483,\"LevenshteinSimilitude\":37.24,\"Similitud_Semantica\":0.3063063063063063,\"SemanticSimilitude\":30.63},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.20253164556962025,\"JaccardSimilitude\":20.25,\"Similitud_Levenshtein\":42.465753424657535,\"LevenshteinSimilitude\":42.47,\"Similitud_Semantica\":0.3153153153153153,\"SemanticSimilitude\":31.53},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.16981132075471697,\"JaccardSimilitude\":16.98,\"Similitud_Levenshtein\":6.557377049180328,\"LevenshteinSimilitude\":6.56,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91},{\"Coincidencias\":66,\"Coincidences\":66,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.12966601178781925,\"JaccardSimilitude\":12.97,\"Similitud_Levenshtein\":20.28985507246377,\"LevenshteinSimilitude\":20.29,\"Similitud_Semantica\":0.2432432432432432,\"SemanticSimilitude\":24.32},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.1744186046511628,\"JaccardSimilitude\":17.44,\"Similitud_Levenshtein\":9.836065573770492,\"LevenshteinSimilitude\":9.84,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.1351931330472103,\"JaccardSimilitude\":13.52,\"Similitud_Levenshtein\":22.857142857142858,\"LevenshteinSimilitude\":22.86,\"Similitud_Semantica\":0.26126126126126126,\"SemanticSimilitude\":26.13},{\"Coincidencias\":88,\"Coincidences\":88,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.10057142857142858,\"JaccardSimilitude\":10.06,\"Similitud_Levenshtein\":24.096385542168676,\"LevenshteinSimilitude\":24.1,\"Similitud_Semantica\":0.509090909090909,\"SemanticSimilitude\":50.91},{\"Coincidencias\":28,\"Coincidences\":28,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.040697674418604654,\"JaccardSimilitude\":4.07,\"Similitud_Levenshtein\":60.67415730337079,\"LevenshteinSimilitude\":60.67,\"Similitud_Semantica\":0.6181818181818182,\"SemanticSimilitude\":61.82},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.09494640122511486,\"JaccardSimilitude\":9.49,\"Similitud_Levenshtein\":66.66666666666666,\"LevenshteinSimilitude\":66.67,\"Similitud_Semantica\":0.6363636363636364,\"SemanticSimilitude\":63.64},{\"Coincidencias\":61,\"Coincidences\":61,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.08615819209039548,\"JaccardSimilitude\":8.62,\"Similitud_Levenshtein\":15.151515151515152,\"LevenshteinSimilitude\":15.15,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.08591885441527446,\"JaccardSimilitude\":8.59,\"Similitud_Levenshtein\":36.58536585365854,\"LevenshteinSimilitude\":36.59,\"Similitud_Semantica\":0.49090909090909096,\"SemanticSimilitude\":49.09},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.08836524300441827,\"JaccardSimilitude\":8.84,\"Similitud_Levenshtein\":18.181818181818183,\"LevenshteinSimilitude\":18.18,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.08135168961201501,\"JaccardSimilitude\":8.14,\"Similitud_Levenshtein\":38.095238095238095,\"LevenshteinSimilitude\":38.1,\"Similitud_Semantica\":0.5272727272727273,\"SemanticSimilitude\":52.73},{\"Coincidencias\":133,\"Coincidences\":133,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.17205692108667528,\"JaccardSimilitude\":17.21,\"Similitud_Levenshtein\":18.181818181818183,\"LevenshteinSimilitude\":18.18,\"Similitud_Semantica\":0.3414634146341463,\"SemanticSimilitude\":34.15},{\"Coincidencias\":38,\"Coincidences\":38,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.061191626409017714,\"JaccardSimilitude\":6.12,\"Similitud_Levenshtein\":46.55172413793103,\"LevenshteinSimilitude\":46.55,\"Similitud_Semantica\":0.41463414634146345,\"SemanticSimilitude\":41.46},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.10961214165261383,\"JaccardSimilitude\":10.96,\"Similitud_Levenshtein\":52.991452991452995,\"LevenshteinSimilitude\":52.99,\"Similitud_Semantica\":0.426829268292683,\"SemanticSimilitude\":42.68},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.10046367851622875,\"JaccardSimilitude\":10.05,\"Similitud_Levenshtein\":10.75268817204301,\"LevenshteinSimilitude\":10.75,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.0978120978120978,\"JaccardSimilitude\":9.78,\"Similitud_Levenshtein\":27.522935779816514,\"LevenshteinSimilitude\":27.52,\"Similitud_Semantica\":0.3292682926829268,\"SemanticSimilitude\":32.93},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.10355987055016182,\"JaccardSimilitude\":10.36,\"Similitud_Levenshtein\":12.903225806451612,\"LevenshteinSimilitude\":12.9,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":70,\"Coincidences\":70,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.09497964721845319,\"JaccardSimilitude\":9.5,\"Similitud_Levenshtein\":28.82882882882883,\"LevenshteinSimilitude\":28.83,\"Similitud_Semantica\":0.35365853658536583,\"SemanticSimilitude\":35.37}]},\"e7c43279-2bcc-4c09-9165-b824041166fc\":{\"Id\":\"e7c43279-2bcc-4c09-9165-b824041166fc\",\"FirstName\":\"August\",\"LastName\":\"von Kageneck\",\"SubmissionId\":\"6252ac2f-e197-4ec3-821f-56ef3dffc72c\",\"Url\":\"https://www.codiva.io/p/0dc6fsdf99a0-6033-4bb6-b46c-15d238277749\",\"Codes\":{},\"State\":1,\"PlagiResults\":[]}}";

            var analysisResult = JsonConvert.DeserializeObject<Dictionary<Guid, StudentSubmission>>(json);

            /*
            BackgroundJob.Schedule(() =>
                HttpContext.RequestServices
                    .GetRequiredService<HangFireServices>()
                    .SavePlagiarismReport(Guid.Parse("ac85b4e5-33ea-4d2c-a281-f7ec41da15f7"), new string(""), new Dictionary<Guid, StudentSubmission>(analysisResult)),
                new DateTimeOffset(DateTime.UtcNow)
            );
            */

            Guid assignmentId = Guid.Parse("ac85b4e5-33ea-4d2c-a281-f7ec41da15f7");
            string analysisResultJson = json;

            if (string.IsNullOrEmpty(analysisResultJson))
            {
                return Ok();
            }

            var analysisResult2 = JsonConvert.DeserializeObject<Dictionary<Guid, StudentSubmission>>(analysisResultJson);
            /*
            if(analysisResult == null)
            {
                   return;
            }
            else if(analysisResult.Count == 0 || assignmentId == Guid.Empty || _context == null || _context.Assignments == null)
            {
                return;
            }
            */
            var assignment = await _context.Assignments.FindAsync(assignmentId);

            if (assignment == null)
            {
                return Ok();
            }

            StringBuilder data = new();
            StringBuilder data2 = new();

            bool codeValidator = false;
            bool plagiarismValidator = false;

            foreach (var studentSubmission in analysisResult.Values)
            {
                codeValidator = false;
                plagiarismValidator = false;

                if (studentSubmission.Codes == null || studentSubmission.Codes!.Count == 0)
                {
                    continue;
                }

                // File name, id
                Dictionary<string, Guid> GuidsForCodes = [];

                foreach (var code in studentSubmission.Codes)
                {
                    try
                    {
                        Guid CodeId = Guid.NewGuid();

                        await _context.Codes!.AddAsync(new Code
                        {
                            Id = CodeId,
                            SubmissionId = studentSubmission.SubmissionId,
                            FileName = code.Key,
                            Content = code.Value
                        });

                        data2.Append($"\n{CodeId} | {studentSubmission.SubmissionId} | {code.Key}");

                        GuidsForCodes.Add(code.Key, CodeId);
                    }
                    catch (Exception e)
                    {
                        codeValidator = false;
                        Console.WriteLine($"Exception ({GetType().Name}): {e.Message}\n");
                    }
                }

                //await _context.SaveChangesAsync();

                int count = await _context.Codes!.CountAsync(code => code.SubmissionId == studentSubmission.SubmissionId);
                /*
                if (GuidsForCodes == null || GuidsForCodes.Count == 0 || GuidsForCodes.Count != count)
                {
                    continue;
                }
                
                if(GuidsForCodes.Count == count)
                {
                    codeValidator = true;
                }
                */
                count = 0;
                var sortedStudentSubmission = studentSubmission.PlagiResults.OrderBy(plagiResult => plagiResult.FileName1).ToList();
                foreach (var plagiResult in sortedStudentSubmission)
                {
                    try
                    {

                        var Jaccard = Guid.NewGuid();
                        var Levenshtein = Guid.NewGuid();
                        var Semantic = Guid.NewGuid();
                        var Coincidences = Guid.NewGuid();

                        // Jaccard
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Jaccard,
                            Similarity = plagiResult.JaccardSimilitude,
                            Algorithm = Plagiarism.AlgorithmType.Jaccard,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        data.Append($"\n{Jaccard} | {Plagiarism.AlgorithmType.Jaccard} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Levenshtein
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Levenshtein,
                            Algorithm = Plagiarism.AlgorithmType.Levenshtein,
                            Similarity = plagiResult.LevenshteinSimilitude,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        data.Append($"\n{Levenshtein} | {Plagiarism.AlgorithmType.Levenshtein} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Semantic
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Semantic,
                            Algorithm = Plagiarism.AlgorithmType.Semantic,
                            Similarity = plagiResult.SemanticSimilitude,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        data.Append($"\n{Semantic} | {Plagiarism.AlgorithmType.Semantic} | {GuidsForCodes[plagiResult.FileName1]}");

                        // Coincidences
                        await _context.Plagiarisms!.AddAsync(new Plagiarism
                        {
                            Id = Coincidences,
                            Algorithm = Plagiarism.AlgorithmType.Coincidences,
                            Coincidences = plagiResult.Coincidences,
                            CodeId = GuidsForCodes[plagiResult.FileName1]
                        });

                        count += 4;
                        data.Append($"\n{Coincidences} | {Plagiarism.AlgorithmType.Coincidences} | {GuidsForCodes[plagiResult.FileName1]}");
                    }
                    catch (Exception e)
                    {
                        plagiarismValidator = false;
                        Console.WriteLine($"Exception ({GetType().Name}): {e.Message}\n");
                    }
                }

                //await _context.SaveChangesAsync();

                int dbCount = 0;
                /*
                foreach (var code in GuidsForCodes)
                {
                    dbCount += await _context.Plagiarisms!.CountAsync(plagiarism => plagiarism.CodeId == code.Value);
                }

                if (count == dbCount)
                {
                    plagiarismValidator = true;
                }
                */
            }
            Console.WriteLine($"\n--------{data2.ToString()}-------\n");
            Console.WriteLine($"\n--------{data.ToString()}-------\n");
            /*
            if (codeValidator && plagiarismValidator)
            {*/
                assignment.IsAnalyzed = true;
                assignment.AnalysisDate = DateTime.UtcNow;

                await _context.SaveChangesAsync();
            //}

            return Ok();
        }

        [HttpPost]
        [Route("Analyze")]
        public async Task<ActionResult> Analyze(Guid assignmentId)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentId);

            if (assignment == null)
            {
                return NotFound("The assignment not exist.");
            }

            var studentsSubmissions = await _context!.Submissions!
                .Where(submission => submission.AssignmentId == assignmentId)
                .Include(submission => submission.Student)
                .Select(submission => new Submission
                {
                    Id = submission.Id,
                    Url = submission.Url,
                    SubmissionDate = submission.SubmissionDate,
                    StudentId = submission.StudentId,
                    Student = new Student { 
                        FirstName = submission.Student!.FirstName,
                        LastName = submission.Student!.LastName
                    },
                })
                .ToListAsync();
            
            // Verificar que haya al menos 2 entregas
            if (studentsSubmissions == null || studentsSubmissions.Count < 2)
            {
                return BadRequest("There are not enough submissions to analyze.");
            }

            // Verificar que todos los Student no sean nulos
            if (studentsSubmissions.Any(submission => submission.Student == null))
            {
                return BadRequest("Error in DataBase");
            }
            
            WebScraping scraper = new();

            Dictionary<Guid, StudentSubmission> analysisResult = await scraper.StartScraping(studentsSubmissions);
            
            if(analysisResult == null || analysisResult.Count <= 0)
            {
                return BadRequest("Error in scraping");
            }

            string analysisResultJson = JsonConvert.SerializeObject(analysisResult);

            if(!assignment.IsAnalyzed && assignment.AnalysisDate == DateTime.MinValue)
            {
                BackgroundJob.Schedule(() =>
                    HttpContext.RequestServices
                        .GetRequiredService<HangFireServices>()
                        .SavePlagiarismReport(assignmentId, new string(analysisResultJson), new Dictionary<Guid, StudentSubmission>(analysisResult)),
                    new DateTimeOffset(DateTime.UtcNow)
                );
            }

            var document = ReportGenerator.GenerateReport(analysisResult);
            
            // Convertir el PDF a un array de bytes
            using (var memoryStream = new MemoryStream())
            {
                document.Save(memoryStream);
                var pdfBytes = memoryStream.ToArray();

                return File(pdfBytes, "application/pdf", $"PlagiarismReport-{assignmentId}.pdf");
            }
        }

        [HttpGet]
        [Route("GetAllByCourse")]
        public async Task<ActionResult> GetAllByCourse(Guid courseId)
        {
            var course = await _context!.Courses!.FindAsync(courseId);

            if (course == null)
            {
                return NotFound();
            }
            else
            {
                var assignments = await _context!.Assignments!.Where(a => a.CourseId == courseId).ToListAsync();

                if (assignments == null || assignments.Count < 1)
                {
                    return NotFound();
                }

                return Ok(assignments);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<ActionResult> Update(AssignmentUpdateRequest assignmentUpdateRequest)
        {
            var assignment = await _context!.Assignments!.FindAsync(assignmentUpdateRequest.Id);

            if (assignment == null)
            {
                return NotFound();
            }

            assignment.Description = assignmentUpdateRequest.Description;
            assignment.Title = assignmentUpdateRequest.Title;
            assignment.SubmissionDate = assignmentUpdateRequest.SubmissionDate;

            await _context.SaveChangesAsync();
            return Ok();
        }


        [HttpDelete]
        [Route("Delete")]
        public async Task<ActionResult> Delete(Guid id)
        {
            var assignment = await _context!.Assignments!.FindAsync(id);
            _context.Assignments.Remove(assignment!);

            await _context.SaveChangesAsync();
            return Ok();
        }
        [HttpGet]
        [Route("GetById")]
        public async Task<ActionResult> GetById(Guid id)
        {
            var assignment = await _context!.Assignments!.FindAsync(id);

            if (assignment == null)
            {
                return NotFound();
            }

            return Ok(new Assignment()
            {
                Id = assignment.Id,
                Title = assignment.Title,
                Description = assignment.Description,
                SubmissionDate = assignment.SubmissionDate,
                CourseId = assignment.CourseId
            });
        }

    }
}