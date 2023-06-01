
# Bookhive - Bookmark & Quotes


Reading books is much more enjoyable and easy with this app! The features this app offers are:


## Features of the application

- Register and Login
- You can search for thousands of books within the application and access detailed information. You can see information such as the subject, author, publication date, language and number of pages.
- You can save the page you left off while reading a book in the app. So when you want to continue reading, you will not have difficulty remembering where you left off. You can also track what percentage of the book you have read.
- You can save a chapter you like in the book as an excerpt in the app. In this way, you can keep your favorite chapters without scribbling the book. You can see all your quotes in the app and share them on social media if you want.

  
## Used technologies

- Mvvm Design Pattern
- Url Session
- UIKit
- TableView
- ScroolView
- CollectionView
- Xib
- User Default
- Extensions
- Delegate
- Json
- Search Filter
- Auto Layout
- Localization

## Third Part Libraries
- Firebase
- Firestore
- Firebase Authentication
- Eureka 
- Lottie
- Kingfisher

## API

#### GET Books

```http
  GET https://openlibrary.org/works/(olidKey).json
```

| Parameter | Tip     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `olidKey`      | `string` | **Required**. Library key to the book|

Return values

    key,title, cover_i,cover_id,availability,language,cover_edition_key
    author_name, authors,first_publish_year



## Screen Shot

<img src="https://github.com/anlavc/BookHive/assets/50744756/95423a49-8260-45a3-af20-301342b056d0).png" width="300" height="650">  <img src="https://github.com/anlavc/BookHive/assets/50744756/585df8f4-444a-4adb-b1c9-ed5cc6a50fb2.PNG" width="300" height="650"> 
<img src="https://github.com/anlavc/BookHive/assets/50744756/79958e09-8172-4238-be17-7a9e3291e74f.PNG" width="300" height="650">  <img src="https://github.com/anlavc/BookHive/assets/50744756/42e0a138-5c87-409e-b820-0a532ac19898.PNG" width="300" height="650">  

## Promo Video

https://github.com/anlavc/BookHive/assets/50744756/0f6f383f-da6c-477f-b00a-c7f3ef750403
