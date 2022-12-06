const restify = require('restify');

const server = restify.createServer({
    name: 'myapp',
    version: '1.0.0'
});

const todoList = [];

server.use(restify.plugins.acceptParser(server.acceptable));
server.use(restify.plugins.queryParser());
server.use(restify.plugins.bodyParser());

server.get('/getall', (req, res, next) => {
    return res.send(todoList);
});

server.post('/inserttodo', (req, res, next) => {

    const todo = {
        taskId: req.body.taskId,
        title: req.body.title,
        deadline: req.body.deadline
    }
    todoList.push(todo);
    return res.send(true);
});

server.listen(3000, function () {
    console.log('%s listening at %s', server.name, server.url);
});