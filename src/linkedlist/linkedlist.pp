unit LinkedList;
interface

type
	nodeval = integer;
	nodeptr =  ^TNode;
	TNode = record
		data: nodeval;
		next: nodeptr;
	end;
	
	listsize = longint;
	TList = record
		first, last: nodeptr;
		size: listsize;
	end;

{ Init the list (zero first, last pointers and its size) }
procedure LSTInit       (var list: TList);
{ Delete the list (if it is empty, she does nothing) }
procedure LSTDelete     (var list: TList);
{ Add the node to the begin of the list (if it is empty, she "creates" it) }
procedure LSTAddFront   (var list: TList; data: nodeval);
{ Add the node to the end of the list (if it is empty, she "creates" it) }
procedure LSTAddBack    (var list: TList; data: nodeval);
{ Set node's data by her index startx since 0 (if the index uncorrect - runtime error }
procedure LSTSetAt      (var list: TList; data: nodeval; 
						 index: listsize);
{ Get node's data by her index starts since 0 (if the index uncorrect - runtime error) }
function  LSTGetAt      (var list: TList; index: listsize): nodeval;
{ Get a size of list (just reads list.size, because it should be abstraction }
function  LSTGetSize    (var list: TList): listsize;
{ Delete node from begin of list (if the list is empty - runtime error) }
procedure LSTDeleteFront(var list: TList);
{ Retrun is the list empty (just reads list.size, because it should be abstraction}
function  LSTIsEmpty    (var list: TList): boolean;

implementation

procedure LSTInit(var list: TList);
begin
	list.first := nil;
	list.last  := nil;
	list.size  := 0
end;

procedure LSTDelete(var list: TList);
var
	next: nodeptr;
begin
	{* HOW DOES IT WORK
	 * Delete the first node and make the next one (first^.next) first 
	 * and recursive call us until first becomes nil
	 *}
	if list.first = nil then exit;
	
	next := list.first^.next;
	dispose(list.first);
	list.first := next;
	
	LSTDelete(list);
	list.size := 0
end;

procedure LSTAddFront(var list: TList; data: nodeval);
var
	newNode: nodeptr;
begin
	new(newNode);
	{ If the list is empty than newNode^.next will be nil }
	newNode^.next := list.first;
	newNode^.data := data;

	{ Make the newNode first }
	list.first    := newNode;
	{ If the list is empty, than make the newNode last too }
	if list.last = nil then 
		list.last := newNode;

	list.size := list.size + 1
end;

procedure LSTAddBack(var list: TList; data: nodeval);
var
	newNode: nodeptr;
begin
	{* Could be done in another way: 
	 * Call LSTAddFront if the list is empty, 
	 * and if not, use dispose(list.last^.next); 
	 * But I found it not concise and impudent
	 *}
	new(newNode);
	newNode^.next := nil;
	newNode^.data := data;
	{ If the list is empty }
	if list.first = nil 
		{ if it is empty, then the last node will also be the first }
		then list.first      := newNode
		{ If the list is empty, it will result in an error } 
		else list.last^.next := newNode;

	list.last := newNode;
	list.size := list.size + 1

{ The alternative variant (but it needs in ternary operator) 
	if list.first = nil then
	begin
		new(list.first);
		list.last := list.first
	end;
	else
		new(list.last^.next);
		list.last := list.last^.next
	end;
	list.last^.next := nil;
	list.last^.data := data;
}
end;

procedure LSTSetAt(var list: TList; data: nodeval; 
				   index: listsize);
var
	current: nodeptr;
begin
	{* HOW DOES IT WORK
	 * If the indexe zero, then return the first node (list.first). 
	 * Otherwise, run the next node, decrement the index, 
	 * and recursively call our procedure until the index is 0
	 *}
	if index = 0 then
	begin 
		list.first^.data := data;
		exit
	end;

	current    := list.first;
	list.first := list.first^.next;
	LSTSetAt(list, data, index - 1);
	list.first := current;
end;

function LSTGetAt(var list: TList; index: listsize): nodeval;
var
	current: nodeptr;
begin
	{* HOW DOES IT WORK
	 * If the indexe zero, then return the first node (list.first). 
	 * Otherwise, run the next node, decrement the index, 
	 * and recursively call our procedure until the index is 0
	 *}
	if index = 0 then 
	begin
		LSTGetAt := list.first^.data;
		exit
	end;

	current    := list.first;
	list.first := list.first^.next;
	LSTGetAt   := LSTGetAt(list, index - 1);
	list.first := current;
end;

function LSTGetSize(var list: TList): listsize;
begin
	LSTGetSize := list.size
end;

procedure LSTDeleteFront(var list: TList);
var
	tmp: nodeptr;
begin
	tmp := list.first;
	list.first = list.first^.next;
	dispose(tmp);
	
	list.size  := list.size - 1
end;

function LSTIsEmpty(var list: TList): boolean;
begin
	LSTIsEmpty := list.size = 0
end;

end.
