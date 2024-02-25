#  Challenge Day 60 hackingwithswift

Challenge:

- Fetch the data and parse it into User and Friend structs.
- Display a list of users with a little information about them, such as their name and whether they are active right now.
- Create a detail view shown when a user is tapped, presenting more information about them, including the names of their friends.
- Before you start your download, check that your User array is empty so that you don’t keep starting the download every time the view is shown.


first step first...

parse this json file....
https://www.hackingwithswift.com/samples/friendface.json

{
        "id": "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
        "isActive": true,
        "name": "Gale Dyer",
        "age": 28,
        "company": "Cemention",
        "email": "galedyer@cemention.com",
        "address": "652 Gatling Place, Kieler, Arizona, 1705",
        "about": "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
        "registered": "2014-07-05T04:25:04-01:00",
        "tags": [
            "irure",
            "labore",
            "et",
            "sint",
            "velit",
            "mollit",
            "et"
        ],
        "friends": [
            {
                "id": "1c18ccf0-2647-497b-b7b4-119f982e6292",
                "name": "Daisy Bond"
            },
            {
                "id": "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9",
                "name": "Tanya Roberson"
            }
        ]
    },
    
    Mutliple problems with database crashing after changes to class, now I know how to delete them and let the app regen.
    The cookier cutter iso8601 date json conversion did not work either
    
