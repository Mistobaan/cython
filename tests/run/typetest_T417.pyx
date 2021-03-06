# ticket: 417
#cython: autotestdict=True

cdef class Foo:
    pass

cdef class SubFoo(Foo):
    pass

cdef class Bar:
    pass

def foo1(arg):
    """
    >>> foo1(Foo())
    >>> foo1(SubFoo())
    >>> foo1(None)
    >>> foo1(123)
    >>> foo1(Bar())
    """
    cdef Foo val = <Foo>arg

def foo2(arg):
    """
    >>> foo2(Foo())
    >>> foo2(SubFoo())
    >>> foo2(None)
    >>> foo2(123)
    Traceback (most recent call last):
       ...
    TypeError: Cannot convert int to typetest_T417.Foo
    >>> foo2(Bar())
    Traceback (most recent call last):
       ...
    TypeError: Cannot convert typetest_T417.Bar to typetest_T417.Foo
    """
    cdef Foo val = arg

def foo3(arg):
    """
    >>> foo3(Foo())
    >>> foo3(SubFoo())
    >>> foo3(None)
    Traceback (most recent call last):
       ...
    TypeError: Cannot convert NoneType to typetest_T417.Foo
    >>> foo3(123)
    Traceback (most recent call last):
       ...
    TypeError: Cannot convert int to typetest_T417.Foo
    >>> foo2(Bar())
    Traceback (most recent call last):
       ...
    TypeError: Cannot convert typetest_T417.Bar to typetest_T417.Foo
    """
    cdef val = <Foo?>arg


cdef int count = 0

cdef object getFoo():
     global count
     count += 1
     return Foo()

def test_getFoo():
    """
    >>> test_getFoo()
    1
    """
    cdef int old_count = count
    cdef Foo x = getFoo()
    return count - old_count

def test_getFooCast():
    """
    >>> test_getFooCast()
    1
    """
    cdef int old_count = count
    cdef Foo x = <Foo?>getFoo()
    return count - old_count
