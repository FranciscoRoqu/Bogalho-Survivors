{
  "$GMObject":"",
  "%Name":"obj_bullet_parent",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"obj_enemy_parent","path":"objects/obj_enemy_parent/obj_enemy_parent.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"obj_solid","path":"objects/obj_solid/obj_solid.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":7,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_bullet_parent",
  "overriddenProperties":[],
  "parent":{
    "name":"Bullets",
    "path":"folders/Objects/Weapons/Bullets.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"owner_id","filters":[],"listItems":[],"multiselect":false,"name":"owner_id","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"bullet_explosion","filters":[],"listItems":[],"multiselect":false,"name":"bullet_explosion","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"bullet_speed","filters":[],"listItems":[],"multiselect":false,"name":"bullet_speed","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"10","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"knockback_time","filters":[],"listItems":[],"multiselect":false,"name":"knockback_time","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"5","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"range","filters":[],"listItems":[],"multiselect":false,"name":"range","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"300","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage","filters":[],"listItems":[],"multiselect":false,"name":"damage","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_type","filters":[],"listItems":[],"multiselect":false,"name":"damage_type","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":null,
  "visible":true,
}