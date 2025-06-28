unit stack;
interface

type
	nodeval = Pointer;
	nodeptr = ^Node;
	Node = record
		data: nodeval;
		next: nodeptr;
	end;

	TStack = nodeptr;

{ Init the stack (zero pointer) }
procedure SInit   (var stack: TStack);
{ Add the new node to the stack }
procedure SPush   (var stack: TStack; data: nodeval);
{ Pop the last node from the stack (if it is empty -> runtime error }
procedure SPop    (var stack: TStack; var data: nodeval);
{ Get the last node from the stack (if it is empty -> runtime error }
function  SPeek   (var stack: TStack): nodeval;
{ Get is stack empty }
function  SIsEmpty(var stack: TStack): boolean;

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
	stack         := newNode
end;

procedure SPop(var stack: TStack; var data: nodeval);
var
	second: nodeptr;
begin
	second  := stack^.next;
	data    := stack^.data;
	dispose(stack);
	stack := second;
end;

function SPeek(var stack: TStack): nodeval;
begin
	SPeek := stack^.data;
end;

function SIsEmpty(var stack: TStack): boolean;
begin
	SIsEmpty := stack = nil
end;

end.
