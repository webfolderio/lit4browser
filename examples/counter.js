import { observable, makeObservable, action } from '../dist/mobx.js';
import { MobxLitElement } from '../dist/lit-mobx.js';
import { html } from '../dist/lit-html.js';

class CounterElement extends MobxLitElement {

    constructor() {
        super();
        this.value = 0;
        makeObservable(this, {
            value: observable,
            increment: action,
            decrement: action,
            change: action
        });
    }

    render() {
        return html`
            <input value="${this.value}" @change="${this.change}">
            <input type="button" value="+" @click="${this.increment}">
            <input type="button" value="-" @click="${this.decrement}">
        `;
    }

    change(e) {
        this.value = parseInt(e.target.value, 10);
    }

    increment() {
        this.value++;
    }

    decrement() {
        this.value--;
    }
}

customElements.define('x-counter', CounterElement);
