# Real Valued 2D Vector Type
mutable struct Vec2{T} <: AbstractVector{T}
    x::T
    y::T
end

# Constructors
Vec2(x::T) where T = Vec2{T}(x, x)           # Uniform 2D vector

# Base functions
Base.getindex(v::Vec2, i::Int) = i == 1 ? v.x : v.y # Get element at index i
Base.setindex!(v::Vec2, val, i::Int) = i == 1 ? (v.x = val) : (v.y = val) # Set element at index i

# Vector operations
dot(v1::Vec2, v2::Vec2) = v1.x * v2.x + v1.y * v2.y # Dot product
norm(v::Vec2) = sqrt(v.x^2 + v.y^2) # Norm
normalize(v::Vec2) = v / norm(v) # Normalize
cross(v1::Vec2, v2::Vec2) = v1.x * v2.y - v1.y * v2.x # Cross product

# Arithmetic operations
Base.:+(v1::Vec2, v2::Vec2) = Vec2(v1.x + v2.x, v1.y + v2.y) # Addition
Base.:-(v1::Vec2, v2::Vec2) = Vec2(v1.x - v2.x, v1.y - v2.y)  # Subtraction
Base.:*(a::T, v::Vec2) where T <: Number = Vec2(a * v.x, a * v.y) # Scalar multiplication
Base.:*(v::Vec2, a::T) where T <: Number = Vec2(a * v.x, a * v.y) # Scalar multiplication
Base.:/(v::Vec2, a::T) where T <: Number = Vec2(v.x / a, v.y / a) # Scalar division

# Comparison operations
Base.:(==)(v1::Vec2, v2::Vec2) = v1.x == v2.x && v1.y == v2.y # Equality
Base.:(!=)(v1::Vec2, v2::Vec2) = v1.x != v2.x || v1.y != v2.y # Inequality

# Print
Base.show(io::IO, v::Vec2) = print(io, "Vec2{", eltype(v), "}(", v.x, ", ", v.y, ")")
Base.show(io::IO, ::MIME"text/plain", v::Vec2) = show(io, v)
Base.show(io::IO, ::MIME"text/html", v::Vec2) = show(io, v)
