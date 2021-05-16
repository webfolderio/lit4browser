import { makeAutoObservable } from '../../dist/mobx.js';
import { MobxLitElement } from '../../dist/lit-mobx.js';
import { html } from '../../dist/lit-html.js';
import { css } from '../../dist/lit-element.js';

class TodoItem {

    _value: string;
    _done: boolean;

    constructor(value?: string) {
        this._value = value ? value : '';
        this._done = false;
        makeAutoObservable(this);
    }

    get value(): string { return this._value; }

    set value(value: string) { this._value = value; }

    get done(): boolean { return this._done; }

    set done(done: boolean) { this._done = done; }
}

class Todo {

    items: Array<TodoItem>;

    constructor() {
        this.items = [];
        makeAutoObservable(this);
    }

    add(todo: string) {
        if (!todo || todo.trim() === '') {
            alert('empty todo item is not accepted!');
            return;
        }
        this.items.push(new TodoItem(todo));
    }

    remove(index: number) {
        this.items.splice(index, 1);
    }

    done(index: number) {
        this.items[index].done = !this.items[index].done;
    }
}

class TodoElement extends MobxLitElement {

    todo: Todo;
    item: string;

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
        this.item = '';
        this.todo = new Todo();
    }

    render() {
        return html`
        <div>item count: ${this.todo.items.length}</div>
        <input  @change="${(e: any) => this.item = e.target.value}"
                @keydown="${(e: any) => e.key === 'Enter' ? this.todo.add(this.item = e.target.value) : undefined }">
        <input type="button" value="add" @click="${() => this.todo.add(this.item)}">
        <ul>
            ${this.todo.items.map((next, i) => html`
                <li class="${next.done ? 'done' : 'undone'}">${next.value}
                    <input type="button" value="remove" @click="${() => this.todo.remove(i)}">
                    <input type="button" value="done" @click="${() => this.todo.done(i)}">
                </li>`)
            }
        </ul>
        `;
    }
}

customElements.define('x-todo', TodoElement as any);
