# Photogram WRITE

In this project, we'll be working with the same old domain model:

![Domain Model](erd.png?raw=true "Domain Model")

In this project, our starting point is the [target of the last project, Photogram READ](https://photogram-read-target.herokuapp.com/). Our goal is to add the last piece: allowing users to _WRITE to_ our database, in addition to _READing from_ it.

### Here is [our new target](https://photogram-write-target.herokuapp.com/).

[https://photogram-write-target.herokuapp.com/(https://photogram-write-target.herokuapp.com/)

## Setup

 1. From [your Cloud9 repositories list](https://c9.io/account/repos), set up a workspace [as usual](https://guides.firstdraft.com/starting-on-a-project-in-cloud9).
 1. Set up the project: `bin/setup`
 1. Start the web server by clicking "Run Project".
 1. Navigate to your live application preview. You should see the "Yay! You're on Rails" page.
 1. Run `rails dummy:reset` to pre-populate your tables with some dummy development data.
 1. As you work, remember to navigate to `/git` and **always be committing**.

> Note that if for some reason later you want to reset the database again, you need to first destroy it:
>
> ```bash
> rails db:drop
> ```
>
> and then re-create and re-populate it:
>
> ```bash
> rails db:migrate
> rails dummy:reset
> ```

## Tasks

Ultimately, your task is: make your app's behavior match the target (ignoring styling).

But, here's a broken out list of tasks:

### /delete_photo/[ID]

When a user visits e.g. `/delete_photo/42`, the row in the photos table with the ID of `42` should be deleted.

After the record has been deleted, the user should be forwarded to `/popular`.

On the photo details page, add a link to make it easy to delete photos (rather than having to type `/delete_photo/42` into the address bar).

### /photos/new

When a user visits `/photos/new`,

 - Display a form with:
    - A text input for the URL of an image.
    - A textarea for a caption.
    - A dropdown list of usernames.
    - A button to "Add photo".
 - When the form is submitted, it should send the user to `/create_photo`, along with the info that they typed into the form as a query string.

#### Hints

##### Textareas

Textareas are one of the few form controls that do not use the `<input>` element with a `type=""` attribute to specify a variant. Instead, they get their own element: `<textarea>`:

```html
<textarea></textarea>
```

Unlike `<input>`, `<textarea>` does require a closing tag. You can still use `name=""`, `id=""`, and `placeholder=""` attributes the same way you do with `<input>`:

```html
<textarea name="pic_caption" id="caption_box" placeholder="Enter a caption for the photo..."></textarea>
```

If you want to, you can also specify the height of a `<textarea>` using the `rows=""` attribute:

```html
<textarea name="pic_caption" id="caption_box" placeholder="Enter a caption for the photo..." rows="10"></textarea>
```

##### Dropdowns

The HTML for a dropdown is very similar to the HTML for an unordered list. Use `<select>` instead of `<ul>` and `<option>` instead of `<li>`:

```html
<select>
  <option>Catherina</option>
  <option>Jolie</option>
  <option>Trina</option>
</select>
```

However, _usually_ we want the form to display a friendly thing (like a username) in the dropdown, but submit a more useful thing (like an ID number) into the query string (and thus the `params` hash of the next action).

To achieve this, we use the `value=""` attribute on the `<option>` elements:

```html
<select name="poster_id" id="user_dropdown">
  <option value="98">Catherina</option>
  <option value="96">Jolie</option>
  <option value="82">Trina</option>
</select>
```

And, of course, we'll usually use embedded Ruby to create all of these `<option>`s, rather than handwriting the HTML. It will usually be a `.each` very similar to when we drew multiple rows from a table on an index page:

```erb
<select name="poster_id" id="user_dropdown">
  <% @all_users.each do |a_user| %>
    <option value="<%= a_user.id %>">
      <%= a_user.username %>
    </option>
  <% end %>
</select>
```

### /create_photo

When a user visits `/create_photo` along with a query string containing photo info, enter a new record in the photos table based on the info.

After the record has been saved, the user should be forwarded to `/recent`.

### /photos/[ID]/edit

When a user visits e.g. `/photos/42/edit`, look up the row in the photos table with the ID of `42` and then:

 - Display a form with:
    - A text input pre-populated with the URL of its image.
    - A textarea pre-populated with its caption.
    - A button to "Update photo".
 - When the form is submitted, it should send the user to `/update_photo/42`, along with the info that they typed into the form as a query string.

#### Hints

 - To pre-populate `<input>` elements, we use the `value=""` attribute:

    ```html
    <input value="https://robohash.org/eligendiprovidentsed.png?size=300x300&set=set1" type="text" name="photo_image" id="image_input" placeholder="Enter a URL for the image...">
    ```
 - To pre-populate `<textarea>` elements, make the stuff you want to show up **the content of the element**:

    ```html
    <textarea name="pic_caption" id="caption_box" placeholder="Enter a caption for the photo...">Every flight begins with a fall.</textarea>
    ```

### /update_photo/[ID]

When a user visits e.g. `/update_photo/42` along with a query string containing photo info, look up the row in the photos table with the ID of `42` and then update the record based on the info.

After the record has been saved, the user should be forwarded to the details page of the photo, i.e. `/photos/42`.
