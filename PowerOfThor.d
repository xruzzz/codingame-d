/**
	Если хотите скомпилировать этот исходник удалите строки, помеченные в комментариях знаком "--". Блоки помеченны знаками "<--" "-->"

	Решение задачи Power of Thor с сайта codingame.com на языке программирования D
	Смысл задачи в поиске короткого пути до цели.
	License GPL2
	Copyright AX 2015
*/
import std.stdio, std.system, std.conv, std.socket, std.path, std.math, std.numeric, std.algorithm, core.thread, std.process;
import ax.multi.labels, ax.application.configurations, ax.console.ins, ax.console.outs;	// --
enum Persons {L = "☠", T = ">"};
enum Trileans {V = -1, O, A};

class Points
{
	public:
		this(string idd, int xx, int yy)
		{
			id = idd;
			x = xx;
			y = yy;
		}
		string id;
		int x;
		int y;
	private:

}

struct Directions
{
	public:
		this(Trileans xx, Trileans yy)
		{
			x = xx;
			y = yy;
		}
		Trileans x;
		Trileans y;
	private:

}

Trileans getTrileans (int x)
{
	return (x > 0) ? Trileans.A : (x < 0 ? Trileans.V : Trileans.O) ;
}

Directions findDir (Points selfPos, Points goal)
{

	return Directions(getTrileans(goal.x -selfPos.x) , getTrileans(goal.y -selfPos.y));
}

string dir2string (Directions din)
{
	return ((din.y == Trileans.V) ? "N" : ((din.y == Trileans.A) ? "S" : "") ) ~ ((din.x == Trileans.V) ? "W" : ((din.x == Trileans.A) ? "E" : ""));
}


void main()
{
	immutable speed = 1000;
	// <-- Удалить весь блок ниже, начало:
	auto cf = new Configurations("pname");
	immutable n = 8;
	Labels[n] l;
	foreach (uint i; 0..n)
	{
		l[i] = new Labels;
	}
	l[0].id(1);
	l[0].name(cf.appNameTrans);
	writeln(l[0].name);
	// --> Конец блока
	Persons pe;
	auto aCases= [[[31,4] , [5,4]] ,[[31,4] , [31,17]] ,[[0,17] , [31,4]] ,[[36,17] , [0,0]]];
	foreach (ik; 0..4)
	{
		Points p[] = [new Points("☠", aCases[ik][0][0],aCases[ik][0][1]),new Points("♛", aCases[ik][1][0],aCases[ik][1][1])];
		Fields f;
		Directions dir;
		foreach (i, cu; p)
		f.ob[i] = cu;
		while (true)
		{
			version (Windows) system("cls");
			else version (Posix) system("clear");
			writeln("\n\tTest Case " , ik+1, "\n");
			f.update;
			if ((p[0].x == p[1].x) && (p[0].y == p[1].y))
			{
				writeln("\n\tSuccess test case " , ik+1, "\n");
				break;
			}
			else
				if (p[1].x < 0 || p[1].y < 0 || p[1].y >= 18 || p[1].x >= 40)//readKey() == 'z'
				{
					writeln("\n\tFail " , ik+1, "\n");
					break;
				}	
				else
				{
					writeln(" Direction: ", dir2string( dir ));
					Thread.sleep( dur!("msecs")( speed) );
					dir = findDir(p[1], p[0]);
					p[1].x = p[1].x+to!int(dir.x);
					p[1].y = p[1].y+to!int(dir.y);
				}
		}
		Thread.sleep( dur!("msecs")(  speed*4 ) );
	}
}

struct Fields
{
	bool clear()
	{
		return true;	
	}
	bool update()
	{
		string field[18];
		char [] b;
		char [] ba;
		if ((ob[0].y == ob[1].y) && (ob[0].x != ob[1].x))
		{
			if (ob[0].x > ob[1].x)
			{
				b.length = ob[1].x;
				ba.length = ob[0].x-ob[1].x -1;
				b[] = ' ';
				ba[] = ' ';
				field[ob[0].y] = to!string(b) ~ ob[1].id ~ to!string(ba) ~ ob[0].id;
			}
			else
				if (ob[0].x < ob[1].x)
				{
					b.length = ob[0].x;
					ba.length = ob[1].x-ob[0].x - 1;
					b[] = ' ';
					ba[] = ' ';
					field[ob[0].y] = to!string(b) ~ ob[0].id ~ to!string(ba) ~ ob[1].id;
				}
		}
		else
			foreach(p; ob)
			{
				b.length = p.x;
				b[] = ' ';
				field[p.y] = to!string(b) ~ p.id;
			}
		foreach(i, line; field)
			writeln(i, "\t |", line);		
		return true;	
	}
	Points [2]ob;
}
