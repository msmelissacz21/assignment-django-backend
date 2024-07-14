from django.http import JsonResponse

def test(request):
    return JsonResponse({"test":1})

def recipe(request):
    return JsonResponse({"Recipe":"Soup"})