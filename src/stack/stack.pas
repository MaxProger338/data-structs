program stack;
interface

type
	nodeval = Pointer;
	nodeptr: ^Node;
	Node: record =
		data: nodeval;
		next: nodeptr;
	end;

	TStack: nodeptr;

procedure SInit(var stack: TStack);
procedure SPush(var stack: TStack; data: nodeval);
procedure SPop(var stack: TStack; var data: nodeval);
procedure SPeek(var stack: TStack; var data: nodeval);
procedure SIsEmpty(var stack: TStack): boolean;

implementation

procedure SInit(var stack: TStack);
begin
	stack := nil;
end;

procedure SPush(var stack: TStack; data: nodeval);
var
	newNode: nodeptr;
begin
	new(newNode);
	newNode^.next := stack;
	newNode^.data := data;
	stack         := newNode;
end;

procedure SPop(var stack: TStack; data: nodeval);
var
	second: nodeptr;
begin
	second := stack^.next;
	dispose(stack);
	stack := second;	
end.
