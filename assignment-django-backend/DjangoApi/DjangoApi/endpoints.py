from django.http import JsonResponse

def photos(request):
    response = JsonResponse(
        {"images":[ { "src": './photos/recipePhotos/food-1.jpg', "description": 'Photo 1 Description' },
                    { "src": './photos/recipePhotos/food-2.jpg', "description": 'Photo 2 Description' },
                    { "src": './photos/recipePhotos/food-3.jpg', "description": 'Photo 3 Description' },
                    { "src": './photos/recipePhotos/food-4.jpg', "description": 'Photo 4 Description' },
                    { "src": './photos/recipePhotos/food-5.jpg', "description": 'Photo 5 Description' },
                    { "src": './photos/recipePhotos/food-6.jpg', "description": 'Photo 6 Description' },
                    { "src": './photos/recipePhotos/food-7.jpg', "description": 'Photo 7 Description' },
                    { "src": './photos/recipePhotos/food-8.jpg', "description": 'Photo 8 Description' },
                    { "src": './photos/recipePhotos/food-9.jpg', "description": 'Photo 9 Description' }
                ]
        }
    )
    return response


def about(request):
    response = JsonResponse({"aboutString1":"Welcome to our website! We are dedicated to providing the best service to our customers. Our team works hard to meet your needs and exceed your expectations.",
                             "aboutString2":"Our mission is to deliver high-quality products and ensure customer satisfaction. Thank you for choosing us!"
                             })
    return response
