/**
 * Global Property Registry for Structs/Dictionaries
 * Maps property string keys to static integer offsets.
 */
export class PropertyRegistry {
    constructor() {
        this.propertyMap = new Map();
        this.nextPropertyIndex = 0;
    }

    getPropertyIndex(name) {
        if (!this.propertyMap.has(name)) {
            this.propertyMap.set(name, this.nextPropertyIndex++);
        }
        return this.propertyMap.get(name);
    }
}
