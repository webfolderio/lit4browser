import { observable, makeObservable, action } from '../dist/mobx.js';
import { MobxLitElement } from '../dist/lit-mobx.js';
import { html } from '../dist/lit-html.js';
import { css } from '../dist/lit-element.js';

class Todo {

    constructor() {
        this.todos = observable([]);
        makeObservable(this, {
            add: action,
            remove: action,
            done: action
        });
    }

    add(todo) {
        this.todos.push({ value: todo, done: false });
    }

    remove(index) {
        this.todos.splice(index, 1);
    }

    done(index) {
        this.todos[index].done = !this.todos[index].done;
        console.info(this.todos[index].done);
    }
}

class TodoElement extends MobxLitElement {

    static get styles() {
        return [
            css`
                ul {
                    list-style: none;
                    padding-left: 0;
                }
                .done {
                    text-decoration: line-through;
                }
            }`
        ]
    }

    constructor() {
        super();
        this.txtTodo = '';
        this.todo = new Todo();
    }

    render() {
        return html`
        <input  @change="${(e) => this.txtTodo = e.target.value}"
                @keydown="${(e) => e.key === 'Enter' ? this.todo.add(this.txtTodo) : undefined }">
        <input type="button" value="add" @click="${() => this.todo.add(this.txtTodo)}">
        <ul>
            ${this.todo.todos.map((next, i) => html`
                <li class="${next.done ? 'done' : 'undone'}">${next.value}
                    <input type="button" value="remove" @click="${() => this.todo.remove(i)}">
                    <input type="button" value="done" @click="${() => this.todo.done(i)}">
                </li>`)
            }
        </ul>
        `;
    }
}

customElements.define('x-todo', TodoElement);
